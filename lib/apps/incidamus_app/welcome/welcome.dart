import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/onlyphotoandtext.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals/model/simple_text_model.dart';

import '../../app_base.dart';

class Welcome extends OnlyPhotoAndText {
  Welcome(
      {InstallApp installApp,
        HomeMenuModel homeMenu,
        BackgroundModel pageBG,
        DrawerModel drawer,
        DrawerModel endDrawer,
        MenuDefModel adminMenu})
      : super(IDENTIFIER, installApp, homeMenu, pageBG, drawer, endDrawer,
      adminMenu, .3, PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple, addLogo: true);

  static String IDENTIFIER = "welcome";

  Future<void> run() {
    installPhotoAndText("Welcome", contents(), DecorationComponentPosition.LeftIfSpaceAvailableOtherwiseBottom,
        assetLocation(), align: SimpleTextAlign.Center) ;
  }

  String assetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/decorating/face1.png';

  String contents()  => """
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
TATTOO\n\n""";
}
