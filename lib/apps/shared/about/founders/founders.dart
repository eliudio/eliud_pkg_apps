import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_model/component/section_model.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_model/shared/background_model.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../../app_base.dart';

abstract class Founders extends AboutBase {
  Founders(InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu) : super(RelativeImagePosition.Aside, .3, SectionImageAlignment.Left, installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  Future<void> doItForFounders() {
    return (doIt());
  }

  String imageURL() => "https://live.staticflickr.com/65535/49984599212_bae71534e2_o_d.png";
}
