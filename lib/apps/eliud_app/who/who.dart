import 'package:eliud_model/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/founders/founders.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../app_base.dart';

class Who extends Founders {
  Who({
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
  String aboutText() =>
      "Hello guys. We are Thomas and Charlotte and we are the authors of Eliud. We need to build lots of websites ourselves, and we don't like to repeat, repeat is boring. So, we've built this platform to allow to quickly present lovely content, through all devices available. Flutter is technology that allows to quickly do this. However, it still requires coding. We like content management systems. However, they don't support future platforms, don't support apps. Bringing these 2 ideas together and eliud was born.";

  @override
  String aboutTitle() => "Who's who and why?";
}
