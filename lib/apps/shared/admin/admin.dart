import 'package:eliud_model/model/admin_app.dart';
import 'package:eliud_model/model/background_model.dart';
import 'package:eliud_model/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'menus.dart';

abstract class AdminBase extends AppSection {
  AdminBase(InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG,
      DrawerModel drawer, DrawerModel endDrawer)
      : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, null);

  static String IDENTIFIER = "ADMIN";
  String adminTitle();

  /*
   * Create the admin menu, referencing the admin popup-menu. Setup the appbar with that admin menu. Then return the admin popup-menu so it can be used in the other
   * menu's, in the other appBars in the other pages.
   */
  Future<MenuDefModel> doIt({
      RgbModel textColor,
      BackgroundModel background,
      RgbModel iconColor,
      RgbModel menuItemColor,
      RgbModel selectedMenuItemColor,
      RgbModel menuBackgroundColor,
      RgbModel appBarMenuItemColor,
      RgbModel appBarSelectedMenuItemColor,
      RgbModel appBarMenuBackgroundColor}
      ) =>  AdminApp.menu(installApp.appId).then((adminPopupMenu) => AdminMenu(installApp.appId).run(adminPopupMenu).then((adminMenu) {
        return installApp.appBar(IDENTIFIER, adminMenu, adminTitle())
          .then((appBar) => AdminApp(installApp.appId,
                drawer,
                endDrawer,
                appBar,
                homeMenu,
                appBarMenuItemColor,
                appBarSelectedMenuItemColor,
                appBarMenuBackgroundColor)
            .run()
            .then((_) => adminPopupMenu));
      }));

  Future<MenuDefModel> run();
}
