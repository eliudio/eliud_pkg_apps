import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_component.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

abstract class PageTemplate extends AppSection {
  final String pageId;
  final PrivilegeLevelRequiredSimple? privilegeLevelRequired;
  final String? packageCondition;
  final ConditionOverride? conditionOverride;

  PresentationImageAlignment? presentationImageAlignment;

  String pageTitle();
  String pageDescription();

  String assetLocation();

  String? componentID();
  String componentName();
  Future<void> setupComponent();

  PageTemplate({required this.pageId, this.privilegeLevelRequired, this.packageCondition, this.conditionOverride, this.presentationImageAlignment, InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(installApp, homeMenu, drawer, endDrawer);

  Future<PageModel> _setupPage(AppBarModel appBar, String? presentationId) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar, presentationId));
  }

  PageModel _page(AppBarModel appBar, String? presentationId) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: pageId,
        componentId: presentationId,
        componentName: AbstractPresentationComponent.componentName));

    return PageModel(
        documentID: pageId,
        appId: installApp!.theApp.documentID,
        title: pageTitle(),
        description: pageDescription(),
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: privilegeLevelRequired,
        ),
        bodyComponents: components);
  }

  PresentationModel _presentation(PlatformMediumModel image) {
    return PresentationModel(
      documentID: pageId,
      appId: installApp!.theApp.documentID,
      bodyComponents: [
        BodyComponentModel(
          documentID: pageId,
          componentId: componentID(),
          componentName: componentName())],
      image: image,
      imagePositionRelative: PresentationRelativeImagePosition.Aside,
      imageAlignment: presentationImageAlignment == null ? PresentationImageAlignment.Right : presentationImageAlignment,
      imageWidth: .40,
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<PresentationModel> _setupPresentation(PlatformMediumModel image) async {
    var presentation = _presentation(image);
    await AbstractRepositorySingleton.singleton.presentationRepository(installApp!.theApp.documentID)!.add(presentation);
    return presentation;
  }

  Future<PlatformMediumModel> uploadImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!,
        assetLocation(), PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple);
  }


  Future<PageModel>  run() async {
    var image = await uploadImage();
    PresentationModel presentationModel = await _setupPresentation(image);
    await setupComponent();
//    var menu = await installApp.appBarMenu("Your Profile", adminMenu);
    var appBar = installApp!.appBar();
    return await _setupPage(appBar, presentationModel.documentID);
  }
}
