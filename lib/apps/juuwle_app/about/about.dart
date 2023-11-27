import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_pkg_fundamentals_model/model/section_model.dart';

import '../../install_app.dart';

class About extends AboutBase {
  About({
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          identifier2,
          RelativeImagePosition.aside,
          1,
          SectionImageAlignment.right,
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  static String identifier2 = "about";

  Future<void> run() {
    return doIt();
  }

  @override
  String aboutText() =>
      "My name is Charlotte. I am the founder of juuwle.com. I enjoy making nice things and people love my litte pieces of art. So, one day I decided to share my products with the wider world. That's how juuwle.com was created. I hope you enjoy my shop.\n\nCharlotte";

  @override
  String aboutTitle() => "About me";

  @override
  String aboutDescription() => "About me";

  @override
  String assetLocation() =>
      'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_sitting.png';
}
