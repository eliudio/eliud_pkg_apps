import 'package:eliud_model/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/shared/about/founders/founders.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../app_base.dart';

class About extends Founders {
  About({
      InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer,
            adminMenu);

  Future<void> run() {
    doItForFounders();
  }

  @override
  String aboutText() => "Minkey was made by these 2 ...";

  @override
  String aboutTitle() => "About";
}
