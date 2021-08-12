import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/founders/founders.dart';

import '../../app_base.dart';

class About extends Founders {
  About({
      InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer,
      })
      : super(installApp, homeMenu, drawer, endDrawer,
            );

  Future<void> run() {
    return doItForFounders();
  }

  @override
  String aboutText() => "Minkey was made by these 2 ...";

  @override
  String aboutTitle() => "About";
}
