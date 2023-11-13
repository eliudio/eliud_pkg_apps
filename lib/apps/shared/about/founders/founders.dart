import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../../install_app.dart';

abstract class Founders extends AboutBase {
  static String identifier2 = 'about';
  Founders(InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer,
      DrawerModel? endDrawer)
      : super(
            identifier2,
            RelativeImagePosition.aside,
            .3,
            SectionImageAlignment.left,
            installApp,
            homeMenu,
            drawer,
            endDrawer);

  Future<void> doItForFounders() {
    return (doIt());
  }

  @override
  String assetLocation() =>
      'packages/eliud_pkg_apps/assets/shared/about/thocha.png';
}
