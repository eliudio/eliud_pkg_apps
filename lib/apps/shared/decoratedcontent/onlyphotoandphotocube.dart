import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_pkg_album/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_album/model/model_export.dart';
import 'package:eliud_pkg_album/model/photo_cube_component.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/photoandsomething.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals/model/simple_text_model.dart';

import '../../app_base.dart';

abstract class OnlyPhotoAndPhotoCube extends PhotoAndSomthing {
  OnlyPhotoAndPhotoCube(
      String identifier,
      InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu,
      double percentageDecorationVisible,
      {bool addLogo,
      PrivilegeLevelRequiredSimple privilegeLevelRequiredSimple})
      : super(identifier, installApp, homeMenu, pageBG, drawer, endDrawer,
            adminMenu, percentageDecorationVisible,
            addLogo: addLogo,
            privilegeLevelRequiredSimple: privilegeLevelRequiredSimple);

  Future<PhotoCubeModel> createPhotoCube(
      String appId, String title, List<PhotoCubeMediumModel> items,
      {SimpleTextAlign align}) async {
    var photoCubeMediumModel = PhotoCubeModel(
        documentID: identifier,
        appId: appId,
        title: title,
        description: title,
        size: 1000,
        items: items,
        conditions: ConditionsSimpleModel(
            privilegeLevelRequired: privilegeLevelRequiredSimple));
    await photoCubeRepository(appId: appId).add(photoCubeMediumModel);
    return photoCubeMediumModel;
  }

  Future<void> installPhotoAndCube(String title,
      DecorationComponentPosition imagePosition, String imageAssetLocation, List<PhotoCubeMediumModel> items,
      {SimpleTextAlign align}) async {
    var photoCube = await createPhotoCube(installApp.appId, title, items, align: align);
    var componentId = photoCube.documentID;
    var componentName = AbstractPhotoCubeComponent.componentName;
    return super.installPhoto(componentId, componentName, title, imagePosition, imageAssetLocation);
  }
}
