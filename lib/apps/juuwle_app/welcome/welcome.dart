import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';

class Welcome extends AppSection {
  Welcome(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  static String identifier = "welcome";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(JuuwleApp.juuwleAppId)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "4",
        componentName: AbstractBookletComponent.componentName,
        componentId: welcomeIdentifier));

    return PageModel(
        documentID: identifier,
        appId: JuuwleApp.juuwleAppId,
        title: "Welcome",
        description: "Welcome",
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

  static String welcomeIdentifier = "welcome";

  Future<PlatformMediumModel> uploadWelcomeImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!,
        'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_standing.png',
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  BookletModel _welcome(PlatformMediumModel welcomeImage) {
    List<SectionModel> entries = [];
    {
      entries.add(SectionModel(
          documentID: "1",
          title: "Hello hello!",
          description:
              "Welcome to juuwle.\n\n\nJuuwle is your new favorite online store for all your necklaces, bracelets, and so on. You fancy x, y or z? Then you've come to the right place. Juuwle specialises in a, b and c! You will also be able to find some d, e and f. \n\n\nI hope you enjoy your stay on juuwle.com \n\n\nCharlotte\n\n\nDid you know? For an even better experence: juuwle is available as app on apple store, google play store, and also available as windows, linux and mac application.",
          image: welcomeImage,
          imagePositionRelative: RelativeImagePosition.aside,
          imageAlignment: SectionImageAlignment.right,
          imageWidth: .33,
          links: []));
    }

    return BookletModel(
      documentID: welcomeIdentifier,
      description: "Welcome",
      sections: entries,
      appId: installApp!.theApp.documentID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<void> _setupWelcome(PlatformMediumModel welcomeImage) async {
    await AbstractRepositorySingleton.singleton
        .bookletRepository(JuuwleApp.juuwleAppId)!
        .add(_welcome(welcomeImage));
  }

  Future<PageModel> run() async {
    var welcomeImage = await uploadWelcomeImage();
//    var appMenu = await installApp.appBarMenu("Welcome", adminMenu);
    var appBar = installApp!.appBar();
    await _setupWelcome(welcomeImage);
    //await _setupFader();
    return await _setupPage(appBar);
  }
}
