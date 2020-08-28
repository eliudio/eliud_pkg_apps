import 'package:eliud_model/model/app_bar_model.dart';
import 'package:eliud_model/model/background_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_model/model/menu_def_model.dart';

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
