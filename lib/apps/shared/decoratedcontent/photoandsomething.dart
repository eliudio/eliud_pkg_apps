import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/decoratedcontent.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals/model/simple_image_component.dart';
import 'package:eliud_pkg_fundamentals/model/simple_image_model.dart';

import '../../app_base.dart';

abstract class PhotoAndSomthing extends DecoratedContent {
  PhotoAndSomthing(
      String identifier,
      InstallApp? installApp,
      HomeMenuModel? homeMenu,      DrawerModel? drawer,
      DrawerModel? endDrawer,
      double percentageDecorationVisible,
      {bool? addLogo,
      PrivilegeLevelRequiredSimple? privilegeLevelRequiredSimple})
      : super(identifier, installApp, homeMenu, drawer, endDrawer,
            percentageDecorationVisible,
            addLogo: addLogo,
            privilegeLevelRequiredSimple: privilegeLevelRequiredSimple);

  Future<PlatformMediumModel> installImage(String assetLocation) async {
    return await ImageTools.uploadPublicPhoto(
        installApp!.appId!, installApp!.member!, assetLocation);
  }

  Future<SimpleImageModel> createSimpleImage(
      PlatformMediumModel memberMediumModel) async {
    var simpleImageModel = SimpleImageModel(
      documentID: identifier,
      appId: memberMediumModel.appId,
      title: null,
      image: memberMediumModel,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: getPrivilegeLevelRequiredSimple()),
    );
    await simpleImageRepository(appId: memberMediumModel.appId)!
        .add(simpleImageModel);
    return simpleImageModel;
  }

  Future<void> installPhoto(String? componentId, String componentName, String title, DecorationComponentPosition imagePosition, String imageAssetLocation,
      ) async {
    var memberMediumModel = await installImage(imageAssetLocation);
    var decoration = await createSimpleImage(memberMediumModel);
    var decoratingComponentId = decoration.documentID;
    var decoratingComponentName = AbstractSimpleImageComponent.componentName;
    return super.installDecoratedContent(title, componentId, componentName,
        decoratingComponentId, decoratingComponentName, imagePosition);
  }
}
