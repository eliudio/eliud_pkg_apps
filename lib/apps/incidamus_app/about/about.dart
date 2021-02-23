import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_apps/apps/shared/photoandtext/photoandtext.dart';
import 'package:eliud_pkg_fundamentals/model/photo_and_text_model.dart';

import '../../app_base.dart';

class About extends PhotoAndText {
  About(
      {InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(IDENTIFIER, installApp, homeMenu, pageBG, drawer, endDrawer,
            adminMenu, .5);

  static String IDENTIFIER = "about";

  Future<void> run() {
    doIt();
  }

  @override
  String aboutTitle() => "About me";

  @override
  String assetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/decorating/face2.png';

  @override
  String contents() => """
Hello .. ! I guess if you are reading this you consider yourself sufficiently tough for my challenging page ! In this autobiographic set of texts and images i express my traumas ,fears ,desires ...beauty and odiousness both united in one controversial idiosyncratic character .. 
Because i am completely obsessed with aesthetics i try to transform my spiritual hideousness into a work of art .. i want to find allure in my delirium ..''the art of grotesque''..
In my photographs i express those feelings and thoughts which we
were taught to restrain ... hide ... control ... they became our little secrets which others would probably judge  ..i found strength to face my moments of weakness ...and share them...
This project is dedicated to loneliness , sociophobia ,fear of death , of love , anxiety ,fear of self ,fear or failure , bulimia , paraphilia ,fetishes ,sadism ,masochism and other dark manifestations of human nature..
as well as beauty ,purity ,elegance ,sensitivity and sensuality ...";
""";

  @override
  PhotoAndTextImagePosition position() => PhotoAndTextImagePosition.RightIfSpaceAvailableOtherwiseTop;

  @override
  String title() => "About me";
}
