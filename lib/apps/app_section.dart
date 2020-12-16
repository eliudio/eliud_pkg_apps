import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import 'app_base.dart';

// Required for dialog
class AppSectionBase {
  final InstallApp installApp;
  final Tools newAppTools;

  AppSectionBase(this.installApp, this.newAppTools);
}

// Required for page
class AppSection extends AppSectionBase {
  final HomeMenuModel homeMenu;
  final DrawerModel drawer;
  final DrawerModel endDrawer;
  final MenuDefModel adminMenu;
  final BackgroundModel pageBG;

  AppSection(InstallApp installApp, Tools newAppTools, this.homeMenu, this.pageBG, this.drawer, this.endDrawer, this.adminMenu):
      super(installApp, newAppTools);
}
