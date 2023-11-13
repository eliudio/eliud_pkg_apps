import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:flutter/material.dart';

import '../../app_section.dart';

abstract class AdminBase extends AppSection {
  List<AdminAppMenuInstallerBase> adminMenuInstallers();
  List<AdminAppInstallerBase> adminAppsInstallers(
      String? appID,
      DrawerModel? drawer,
      DrawerModel? theEndDrawer,
      AppBarModel appBar,
      HomeMenuModel? homeMenu);

  AdminBase(super.installApp, super.homeMenu, super.drawer, super.endDrawer);

  String adminTitle();

  MenuItemModel _item(MenuDefModel menu) {
    return MenuItemModel(
        documentID: menu.documentID,
        text: menu.name,
        description: menu.name,
        icon: IconModel(
            codePoint: Icons.fiber_manual_record.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(installApp!.theApp, menuDef: menu));
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
    List<AdminAppMenuInstallerBase> theAdminMenuInstallers =
        adminMenuInstallers();
    List<MenuItemModel> menuItems = await Future.wait(
        theAdminMenuInstallers.map(
            (element) async => _mapIt(await element.menu(installApp!.theApp))));
    MenuDefModel menu = MenuDefModel(
        documentID: "admin_sub_menu",
        appId: installApp!.theApp.documentID,
        name: "Admin Sub Menu",
        menuItems: menuItems);

    return await AbstractRepositorySingleton.singleton
        .menuDefRepository(installApp!.theApp.documentID)!
        .add(menu);
  }

  /*
   * Create the admin menu, referencing the admin popup-menu. Setup the appbar with that admin menu. Then return the admin popup-menu so it can be used in the other
   * menu's, in the other appBars in the other pages.
   */
  Future<void> installAdminAppss(MenuDefModel menu) async {
    var appBar = installApp!.appBar();
    List<AdminAppInstallerBase> installers = adminAppsInstallers(
        installApp!.theApp.documentID, drawer, endDrawer, appBar, homeMenu);
    for (var element in installers) {
      await element.run();
    }
  }
}
