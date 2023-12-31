import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/platform_medium_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals_model/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/section_model.dart';
import 'package:eliud_pkg_shop/wizards/builders/util/image_tools.dart';

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
    return await mainrepo.AbstractRepositorySingleton.singleton
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
        installApp!.member!.documentID,
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
