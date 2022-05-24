import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/shared/decoratedcontent/photoandsomething.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals/model/simple_text_component.dart';
import 'package:eliud_pkg_fundamentals/model/simple_text_model.dart';

import '../../app_base.dart';

abstract class OnlyPhotoAndText extends PhotoAndSomthing {
  OnlyPhotoAndText(
      String identifier,
      InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer,
      double percentageDecorationVisible,
      PrivilegeLevelRequiredSimple privilegeLevelRequiredSimple,
      {bool? addLogo,})
      : super(identifier, installApp, homeMenu, drawer, endDrawer,
            percentageDecorationVisible,
            addLogo: addLogo,
            privilegeLevelRequiredSimple: privilegeLevelRequiredSimple);

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

  Future<void> installPhotoAndText(String title, String contents,
      DecorationComponentPosition imagePosition, String imageAssetLocation,
      {SimpleTextAlign? align}) async {
    var simpleTextModel =
        await createSimpleTextModel(installApp!.theApp.documentID, title, contents, align: align);
    var componentId = simpleTextModel.documentID;
    var componentName = AbstractSimpleTextComponent.componentName;
    return super.installPhoto(componentId, componentName, title, imagePosition, imageAssetLocation);
  }
}
