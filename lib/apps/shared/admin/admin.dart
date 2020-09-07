import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:flutter/material.dart';

import '../../app_section.dart';
import '../../app_base.dart';

abstract class AdminBase extends AppSection {
  List<AdminAppMenuInstallerBase> adminMenuInstallers();
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

  String adminTitle();

  MenuItemModel _item(MenuDefModel menu) {
    return MenuItemModel(
        documentID: menu.documentID,
        text: menu.name,
        description: menu.name,
        icon: IconModel(codePoint: Icons.fiber_manual_record.codePoint, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(menuDef: menu));
  }

  MenuItemModel _mapIt(MenuDefModel menu) {
    return _item(menu);
  }

  /*
   * Create the admin menu, referencing the admin popup-menu. Setup the appbar with that admin menu. Then return the admin popup-menu so it can be used in the other
   * menu's, in the other appBars in the other pages.
   */
  Future<MenuDefModel> installAdminMenus() async {
    // Create the menus
    List<AdminAppMenuInstallerBase> _adminMenuInstallers = adminMenuInstallers();
    List<MenuItemModel> menuItems = await Future.wait(_adminMenuInstallers.map((element) async => _mapIt(await element.menu(installApp.appId))));
    MenuDefModel menu = MenuDefModel(
        documentID: "admin_sub_menu",
        appId: installApp.appId,
        name: "Admin Sub Menu",
        menuItems: menuItems);

    return await AbstractRepositorySingleton.singleton.menuDefRepository().add(menu);
  }

  /*
   * Create the admin menu, referencing the admin popup-menu. Setup the appbar with that admin menu. Then return the admin popup-menu so it can be used in the other
   * menu's, in the other appBars in the other pages.
   */
  Future<void> installAdminAppss(MenuDefModel menu) async {
    var appBar = await installApp.appBar("admin_app_bar", menu, adminTitle());
    List<AdminAppInstallerBase> installers = adminAppsInstallers(
        installApp.appId, drawer, endDrawer, appBar, homeMenu);
    installers.forEach((element) async {
      await element.run();
    });
  }
}
