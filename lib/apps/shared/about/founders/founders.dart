import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../../install_app.dart';

abstract class Founders extends AboutBase {
  static String IDENTIFIER = 'about';
  Founders(InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer) : super(IDENTIFIER, RelativeImagePosition.Aside, .3, SectionImageAlignment.Left, installApp, homeMenu, drawer, endDrawer);

  Future<void> doItForFounders() {
    return (doIt());
  }

  String assetLocation() => 'packages/eliud_pkg_apps/assets/shared/about/thocha.png';
}
