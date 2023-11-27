import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/photoandsomething.dart';
import 'package:eliud_pkg_fundamentals_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals_model/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/simple_text_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/simple_text_model.dart';

abstract class OnlyPhotoAndText extends PhotoAndSomthing {
  OnlyPhotoAndText(
    super.identifier,
    super.installApp,
    super.homeMenu,
    super.drawer,
    super.endDrawer,
    super.percentageDecorationVisible,
    PrivilegeLevelRequiredSimple privilegeLevelRequiredSimple, {
    super.addLogo,
  }) : super(privilegeLevelRequiredSimple: privilegeLevelRequiredSimple);

  Future<SimpleTextModel> createSimpleTextModel(
      String appId, String title, String contents,
      {SimpleTextAlign? align}) async {
    var simpleTextModel = SimpleTextModel(
        documentID: identifier,
        appId: appId,
        title: title,
        text: contents,
        textAlign: align,
        conditions: StorageConditionsModel(
            privilegeLevelRequired: privilegeLevelRequiredSimple));
    await simpleTextRepository(appId: appId)!.add(simpleTextModel);
    return simpleTextModel;
  }

  Future<void> installPhotoAndText(
      String title,
      String description,
      String contents,
      DecorationComponentPosition imagePosition,
      String imageAssetLocation,
      {SimpleTextAlign? align}) async {
    var simpleTextModel = await createSimpleTextModel(
        installApp!.theApp.documentID, title, contents,
        align: align);
    var componentId = simpleTextModel.documentID;
    var componentName = AbstractSimpleTextComponent.componentName;
    return super.installPhoto(componentId, componentName, title, description,
        imagePosition, imageAssetLocation);
  }
}
