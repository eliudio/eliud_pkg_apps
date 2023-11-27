import 'package:eliud_core_main/model/platform_medium_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/decoratedcontent.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals_model/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/simple_image_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/simple_image_model.dart';

abstract class PhotoAndSomthing extends DecoratedContent {
  PhotoAndSomthing(super.identifier, super.installApp, super.homeMenu,
      super.drawer, super.endDrawer, super.percentageDecorationVisible,
      {super.addLogo, super.privilegeLevelRequiredSimple});

  Future<PlatformMediumModel> installImage(String assetLocation) async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!,
        assetLocation,
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  Future<SimpleImageModel> createSimpleImage(
      PlatformMediumModel memberMediumModel) async {
    var simpleImageModel = SimpleImageModel(
      documentID: identifier,
      appId: memberMediumModel.appId,
      description: null,
      image: memberMediumModel,
      conditions: StorageConditionsModel(
          privilegeLevelRequired: getPrivilegeLevelRequiredSimple()),
    );
    await simpleImageRepository(appId: memberMediumModel.appId)!
        .add(simpleImageModel);
    return simpleImageModel;
  }

  Future<void> installPhoto(
    String? componentId,
    String componentName,
    String title,
    String description,
    DecorationComponentPosition imagePosition,
    String imageAssetLocation,
  ) async {
    var memberMediumModel = await installImage(imageAssetLocation);
    var decoration = await createSimpleImage(memberMediumModel);
    var decoratingComponentId = decoration.documentID;
    var decoratingComponentName = AbstractSimpleImageComponent.componentName;
    return super.installDecoratedContent(
        title,
        description,
        componentId,
        componentName,
        decoratingComponentId,
        decoratingComponentName,
        imagePosition);
  }
}
