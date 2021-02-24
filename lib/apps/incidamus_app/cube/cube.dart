import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_album/model/photo_cube_medium_model.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/onlycube.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_model.dart';

import '../../app_base.dart';

class Cube extends OnlyCube {
  Cube(
      {InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(IDENTIFIER, installApp, homeMenu, pageBG, drawer, endDrawer,
            adminMenu, privilegeLevelRequiredSimple: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple);

  static String IDENTIFIER = "cube";

  Future<void> run(MemberModel member) async {
    List<PhotoCubeMediumModel> items = [
      PhotoCubeMediumModel(
        documentID: '1',
        description: 'top',
        memberMedium: await ImageTools.uploadPublicPhoto(installApp.appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/1.jpg'),
      ),
      PhotoCubeMediumModel(
        documentID: '2',
        description: 'left',
        memberMedium: await ImageTools.uploadPublicPhoto(installApp.appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/2.jpg'),
      ),
      PhotoCubeMediumModel(
        documentID: '3',
        description: 'right',
        memberMedium: await ImageTools.uploadPublicPhoto(installApp.appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/3.jpg'),
      ),
      PhotoCubeMediumModel(
        documentID: '4',
        description: 'bottom',
        memberMedium: await ImageTools.uploadPublicPhoto(installApp.appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/4.jpg'),
      ),
      PhotoCubeMediumModel(
        documentID: '5',
        description: 'back',
        memberMedium: await ImageTools.uploadPublicPhoto(installApp.appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/5.jpg'),
      ),
      PhotoCubeMediumModel(
        documentID: '6',
        description: 'front',
        memberMedium: await ImageTools.uploadPublicPhoto(installApp.appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/6.jpg'),
      ),
    ];
    installCube("Photo cube", items);
  }

}
