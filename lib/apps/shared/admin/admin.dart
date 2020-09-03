import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';

abstract class AdminBase extends AppSection {
  List<AdminAppWiperBase> adminAppWipers();
  List<AdminAppInstallerBase> adminAppsInstallers(
      String appID,
      DrawerModel drawer,
      DrawerModel endDrawer,
      AppBarModel appBar,
      HomeMenuModel homeMenu);

  AdminBase(InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu,
      BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer)
      : super(
            installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, null);

  static String IDENTIFIER = "ADMIN";
  String adminTitle();

  MenuItemModel item(MenuDefModel menu) {
    return MenuItemModel(
        documentID: menu.documentID,
        text: menu.name,
        description: menu.name,
        icon: IconModel(codePoint: 0xe9c6, fontFamily: "MaterialIcons"),
        action: PopupMenu(menuDef: menu));
  }

  MenuItemModel mapIt(MenuDefModel menu) {
    return item(menu);
  }

  /*
   * Create the admin menu, referencing the admin popup-menu. Setup the appbar with that admin menu. Then return the admin popup-menu so it can be used in the other
   * menu's, in the other appBars in the other pages.
   */
  Future<MenuDefModel> run() async {
    // create the menu's for all plugins and the main menu that refer to these:
    var appBar = await installApp.appBar(IDENTIFIER, adminMenu, adminTitle());
    List<AdminAppInstallerBase> installers = adminAppsInstallers(
        installApp.appId, drawer, endDrawer, appBar, homeMenu);
    List<MenuItemModel> menuItems = await Future.wait(installers.map((element) async => mapIt(await element.menu(installApp.appId))));
    MenuDefModel menu = MenuDefModel(
        documentID: "admin_sub_menu",
        appId: installApp.appId,
        name: "Admin Sub Menu",
        menuItems: menuItems);
    // run the plugin's installers:
    installers.forEach((element) async {
      await element.run();
    });
    return await AbstractRepositorySingleton.singleton.menuDefRepository().add(menu);
//    return await storeMenu(menu);
  }

/*
  MenuDefModel _adminMenu(MenuDefModel allPluginAdminsMenu) {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "ADMIN",
        text: "Admin",
        description: "Admin",
        icon: IconModel(codePoint: 0xe9c6, fontFamily: "MaterialIcons"),
        action: PopupMenu(menuDef: allPluginAdminsMenu)));
    MenuDefModel menu = MenuDefModel(
        documentID: "admin_menu",
        appId: installApp.appId,
        name: "Admin Menu",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> _storeAdminMenu(MenuDefModel allPluginAdminsMenu) {
    return AbstractRepositorySingleton.singleton
        .menuDefRepository()
        .add(_adminMenu(allPluginAdminsMenu));
  }

  Future<MenuDefModel> storeMenu(MenuDefModel allPluginAdminsMenu) {
    return _storeAdminMenu(allPluginAdminsMenu);
  }
*/
}
