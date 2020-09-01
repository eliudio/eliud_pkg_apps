import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import 'app_base.dart';

class AppSection {
  final InstallApp installApp;
  final Tools newAppTools;
  final HomeMenuModel homeMenu;
  final BackgroundModel pageBG;
  final DrawerModel drawer;
  final DrawerModel endDrawer;
  final MenuDefModel adminMenu;

  AppSection(this.installApp, this.newAppTools, this.homeMenu, this.pageBG, this.drawer, this.endDrawer, this.adminMenu);
}
