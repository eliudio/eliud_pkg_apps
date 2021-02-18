import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../app_base.dart';

class Welcome extends AboutBase {
  Welcome(
      {InstallApp installApp,
        Tools newAppTools,
        HomeMenuModel homeMenu,
        BackgroundModel pageBG,
        DrawerModel drawer,
        DrawerModel endDrawer,
        MenuDefModel adminMenu})
      : super(IDENTIFIER, RelativeImagePosition.Aside, 1, SectionImageAlignment.Left, installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer,
      adminMenu);

  static String IDENTIFIER = "welcome";

  Future<void> run() {
    doIt();
  }

  @override
  String aboutText() => """
FETISHISTIC , HIDEOUS , MESMERISING , UNPLEASANT, EROTIC , ALLURING ,WEIRD , INCONGRUOUS ,SURREAL .
IF YOU PROCEED TO VIEW THIS SITE THEN THE MATERIAL YOU ENCOUNTER MIGHT CREATE A STATE OF STRONG DISGUST OR AROUSAL. CONTEMPLATE THESE RISKS CAREFULLY BEFORE GOING AHEAD AS THIS EXPERIENCE MAY CAUSE LASTING SHOCK AS A RESULT OF THE DISTURBING YET SENSUAL IMAGERY. BY PRESSING "VIEW MORE" -YOU ARE VIEWING THE SITE AT YOUR OWN RISK. ​
AUTOBIOGRAPHIC 
PHOTOGRAPHY
FINE  ART
DEVIANT ART
MENTAL HEALTH
FETISH
LEATHER 
LATEX
TATTOO""";

  @override
  String aboutTitle() => "Welcome";

  @override
  String assetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/decorating/face1.png';
}
