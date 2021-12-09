import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class Welcome extends AppSection {
  Welcome({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer}) : super(installApp, homeMenu, drawer, endDrawer, );

  static String identifier = "welcome";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(JuuwleApp.JUUWLE_APP_ID)!.add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "4", componentName: AbstractBookletComponent.componentName, componentId: welcomeIdentifier));

    return PageModel(
        documentID: identifier,
        appId: JuuwleApp.JUUWLE_APP_ID,
        title: "Welcome",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  static String welcomeIdentifier = "welcome";

  Future<PlatformMediumModel> uploadWelcomeImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.appId, installApp!.member!, 'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_standing.png');
  }

  BookletModel _welcome(PlatformMediumModel welcomeImage) {
    List<SectionModel> entries = [];
    {
      entries.add(SectionModel(
          documentID: "1",
          title: "Hello hello!",
          description: "Welcome to juuwle.\n\n\nJuuwle is your new favorite online store for all your necklaces, bracelets, and so on. You fancy x, y or z? Then you've come to the right place. Juuwle specialises in a, b and c! You will also be able to find some d, e and f. \n\n\nI hope you enjoy your stay on juuwle.com \n\n\nCharlotte\n\n\nDid you know? For an even better experence: juuwle is available as app on apple store, google play store, and also available as windows, linux and mac application.",
          image: welcomeImage,
          imagePositionRelative: RelativeImagePosition.Aside,
          imageAlignment: SectionImageAlignment.Right,
          imageWidth: .33,
          links: []));
    }

    return BookletModel(
      documentID: welcomeIdentifier,
      name: "Welcome",
      sections:entries,
      appId: installApp!.appId,
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> _setupWelcome(PlatformMediumModel welcomeImage) async {
    await AbstractRepositorySingleton.singleton.bookletRepository(JuuwleApp.JUUWLE_APP_ID)!.add(_welcome(welcomeImage));
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
