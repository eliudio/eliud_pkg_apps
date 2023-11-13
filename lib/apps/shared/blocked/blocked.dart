import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';

class Blocked extends AppSection {
  Blocked(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(installApp, homeMenu, drawer, endDrawer);

  static String identifier = "blocked";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractBookletComponent.componentName,
        componentId: blockedIdentifier));

    return PageModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: "Blocked !",
        description: "Blocked !",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  static String blockedIdentifier = "blocked";

  Future<PlatformMediumModel> uploadBlockedImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!,
        'packages/eliud_pkg_apps/assets/shared/blocked/blocked.png',
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  BookletModel _blocked(PlatformMediumModel blockedImage) {
    List<SectionModel> entries = [];
    {
      entries.add(SectionModel(
          documentID: "1",
          title: "Blocked!",
          description: "You are blocked.\n\n\nExplain...",
          image: blockedImage,
          imagePositionRelative: RelativeImagePosition.aside,
          imageAlignment: SectionImageAlignment.right,
          imageWidth: .33,
          links: []));
    }

    return BookletModel(
      documentID: blockedIdentifier,
      description: "Blocked!",
      sections: entries,
      appId: installApp!.theApp.documentID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<void> _setupBlocked(PlatformMediumModel blockedImage) async {
    await AbstractRepositorySingleton.singleton
        .bookletRepository(installApp!.theApp.documentID)!
        .add(_blocked(blockedImage));
  }

  Future<PageModel> run() async {
    var blockedImage = await uploadBlockedImage();
    var appBar = installApp!.appBar();
    await _setupBlocked(blockedImage);
    return await _setupPage(appBar);
  }
}
