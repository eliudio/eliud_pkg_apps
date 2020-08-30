import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_base.dart';

class Admin extends AdminBase {
  Admin(
      {InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer})
      : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer);

  Future<MenuDefModel> run() => doIt(
      textColor: EliudColors.black,
      background: installApp.appBarBG(),
      iconColor: EliudColors.black,
      menuItemColor: EliudColors.black,
      selectedMenuItemColor: EliudColors.green,
      menuBackgroundColor: EliudColors.lightRed,
      appBarMenuItemColor: EliudColors.black,
      appBarSelectedMenuItemColor: EliudColors.green,
      appBarMenuBackgroundColor: EliudColors.lightRed);

  @override
  String adminTitle() => "Admin";
}
