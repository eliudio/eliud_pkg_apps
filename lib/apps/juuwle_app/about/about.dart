import 'package:eliud_model/model/background_model.dart';
import 'package:eliud_model/model/section_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../app_base.dart';

class About extends AboutBase {
  About(
      {InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(RelativeImagePosition.Aside, 1, SectionImageAlignment.Right, installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer,
            adminMenu);

  static String identifier = "about";

  Future<void> run() {
    doIt();
  }

  @override
  String aboutText() =>
      "My name is Charlotte. I am the founder of juuwle.com. I enjoy making nice things and people love my litte pieces of art. So, one day I decided to share my products with the wider world. That's how juuwle.com was created. I hope you enjoy my shop.\n\nCharlotte";

  @override
  String aboutTitle() => "About me";

  @override
  String imageURL() => "https://live.staticflickr.com/65535/50014767468_2c7891d64d_o_d.png";
}
