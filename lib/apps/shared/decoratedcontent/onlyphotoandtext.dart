import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/decoratedcontent.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals/model/simple_image_component.dart';
import 'package:eliud_pkg_fundamentals/model/simple_image_model.dart';
import 'package:eliud_pkg_fundamentals/model/simple_text_component.dart';
import 'package:eliud_pkg_fundamentals/model/simple_text_model.dart';

import '../../app_base.dart';
import 'package:eliud_core/tools/random.dart';

abstract class OnlyPhotoAndText extends DecoratedContent {
  OnlyPhotoAndText(
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

  Future<MemberMediumModel> installImage(String assetLocation) async {
    return await ImageTools.uploadPublicPhoto(
        installApp.appId, installApp.member, assetLocation);
  }

  Future<SimpleImageModel> createSimpleImage(
      MemberMediumModel memberMediumModel) async {
    var simpleImageModel = SimpleImageModel(
      documentID: newRandomKey(),
      appId: memberMediumModel.appId,
      title: null,
      image: memberMediumModel,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: getPrivilegeLevelRequiredSimple()),
    );
    await simpleImageRepository(appId: memberMediumModel.appId)
        .add(simpleImageModel);
    return simpleImageModel;
  }

  Future<SimpleTextModel> createSimpleTextModel(
      String appId, String title, String contents,
      {SimpleTextAlign align}) async {
    var simpleTextModel = SimpleTextModel(
        documentID: newRandomKey(),
        appId: appId,
        title: title,
        text: contents,
        textAlign: align,
        conditions: ConditionsSimpleModel(
            privilegeLevelRequired: privilegeLevelRequiredSimple));
    await simpleTextRepository(appId: appId).add(simpleTextModel);
    return simpleTextModel;
  }

  Future<void> installPhotoAndText(String title, String contents,
      DecorationComponentPosition imagePosition, String imageAssetLocation,
      {SimpleTextAlign align}) async {
    var simpleTextModel =
        await createSimpleTextModel(installApp.appId, title, contents);
    var componentId = simpleTextModel.documentID;
    var componentName = AbstractSimpleTextComponent.componentName;
    var memberMediumModel = await installImage(imageAssetLocation);
    var decoration = await createSimpleImage(memberMediumModel);
    var decoratingComponentId = decoration.documentID;
    var decoratingComponentName = AbstractSimpleImageComponent.componentName;
    return super.installDecoratedContent(title, componentId, componentName,
        decoratingComponentId, decoratingComponentName, imagePosition);
  }
}
