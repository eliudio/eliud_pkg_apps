import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'images.dart';

class Blocked extends AppSection {
  Blocked({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String identifier = "blocked";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp.appId).add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractBookletComponent.componentName, componentId: blockedIdentifier));

    return PageModel(
        documentID: identifier,
        appId: installApp.appId,
        title: "Blocked !",
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        readCondition: ReadCondition.NoRestriction,
        privilegeLevelRequired: NO_PRIVILEGE,
        bodyComponents: components);
  }

  static String blockedIdentifier = "blocked";

  BookletModel _blocked() {
    List<SectionModel> entries = List();
    {
      entries.add(SectionModel(
          documentID: "1",
          title: "Blocked!",
          description: "You are blocked.\n\n\nExplain...",
          image: newAppTools.findImageModel(BlockedImages.blockedePhoto),
          imagePositionRelative: RelativeImagePosition.Aside,
          imageAlignment: SectionImageAlignment.Right,
          imageWidth: .33,
          links: List()));
    }

    return BookletModel(
      documentID: blockedIdentifier,
      name: "Blocked!",
      sections:entries,
      appId: installApp.appId,
    );
  }

  Future<void> _setupBlocked() async {
    await AbstractRepositorySingleton.singleton.bookletRepository(installApp.appId).add(_blocked());
  }

  Future<PageModel> run() async {
    await BlockedImages(newAppTools).run();
    var appBar = await installApp.appBar(identifier, adminMenu, "Blocked");
    await _setupBlocked();
    return await _setupPage(appBar);
  }
}
