import 'package:eliud_model/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';

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
      textColor: EliudColors.white,
      background: installApp.appBarBG(),
      iconColor: EliudColors.white,
      menuItemColor: EliudColors.white,
      selectedMenuItemColor: EliudColors.red,
      menuBackgroundColor: EliudColors.gray,
      appBarMenuItemColor: EliudColors.white,
      appBarSelectedMenuItemColor: EliudColors.blackTransparent,
      appBarMenuBackgroundColor: EliudColors.gray);

  @override
  String adminTitle() => "Admin";
}
