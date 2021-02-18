import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/tool_set.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/incidamus_app.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/incidamus_app.dart';
import 'package:eliud_pkg_apps/apps/tools/dynamic_helper.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/document_component.dart';
import 'package:eliud_pkg_fundamentals/model/document_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/document_model.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'images.dart';

class Welcome extends AppSection {
  Welcome(
      {InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer,
            adminMenu);

  static List<String> IDENTIFIERs = [
    "welcome",
    "welcome_member_level1",
    "welcome_member_level2",
    "welcome_owner"
  ];
  static List<PrivilegeLevelRequired> privilegeLevelsRequired = [
    PrivilegeLevelRequired.NoPrivilegeRequired,
    PrivilegeLevelRequired.Level1PrivilegeRequired,
    PrivilegeLevelRequired.Level2PrivilegeRequired,
    PrivilegeLevelRequired.OwnerPrivilegeRequired
  ];
  static String FADER_IDENTIFIER = 'welcome_fader';
  static String APP_BAR_IDENTIFIER = 'welcome_appbar';

  Future<PageModel> _setupPage(AppBarModel appBar, PrivilegeLevelRequired privilegeLevelRequired) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar, privilegeLevelRequired));
  }

  PageModel _page(AppBarModel appBar, PrivilegeLevelRequired privilegeLevelRequired) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "2",
        componentName: AbstractFaderComponent.componentName,
        componentId: FADER_IDENTIFIER));
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractDividerComponent.componentName,
        componentId: "divider_1"));
    components.add(BodyComponentModel(
        documentID: "4",
        componentName: AbstractBookletComponent.componentName,
        componentId: IDENTIFIERs[privilegeLevelRequired.index]));

    return PageModel(
        documentID: IDENTIFIERs[privilegeLevelRequired.index],
        appId: IncidamusApp.INCIDAMUS_APP_ID,
        title: "Welcome",
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            conditionOverride: ConditionOverride
                .ExactPrivilege // make sure the member only sees exactly the page addressed to him
            ),
        bodyComponents: components);
  }

  Future<void> _setupFader() async {
    return await AbstractRepositorySingleton.singleton
        .faderRepository(installApp.appId)
        .add(_fader());
  }

  FaderModel _fader() {
    List<ListedItemModel> items = List();
    items.add(ListedItemModel(
        documentID: "android",
        description: "Android",
        posSize: installApp.halfScreen(),
        image: newAppTools.findImageModel("android")));
    items.add(ListedItemModel(
        documentID: "macbook",
        description: "Macbook",
        posSize: installApp.halfScreen(),
        image: newAppTools.findImageModel("macbook")));
    items.add(ListedItemModel(
        documentID: "iphone",
        description: "iphone",
        posSize: installApp.halfScreen(),
        image: newAppTools.findImageModel("iphone")));
    items.add(ListedItemModel(
        documentID: "tablet",
        description: "Tablet",
        posSize: installApp.halfScreen(),
        image: newAppTools.findImageModel("tablet")));
    FaderModel model = FaderModel(
      documentID: FADER_IDENTIFIER,
      name: "Welcome fader",
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: IncidamusApp.INCIDAMUS_APP_ID,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
    return model;
  }

  String _welcomePageContents(PrivilegeLevelRequired privilegeLevelRequired) {
    var privilegeLevelString = privilegeLevelIntToMemberRoleString(privilegeLevelRequired.index, false);
    return "Hello!\n"
            "Welcome back to Incidamus." +
                ((privilegeLevelRequired.index == 0)
                    ? "You are not yet registered. Why not JOIN?"
                    : "You are registered as $privilegeLevelString");
  }
/*

  DocumentModel _welcomeDocument(PrivilegeLevelRequired privilegeLevelRequired) {
    List<DocumentItemModel> list = List();
    DocumentModel document = DocumentModel(
        documentID: IDENTIFIERs[privilegeLevelRequired.index],
        name: "First document",
        content: _welcomePageContents(privilegeLevelRequired),
        documentRenderer: DocumentRenderer.dynamic_widget,
        appId: IncidamusApp.INCIDAMUS_APP_ID,
        images: list,
        padding: 10,
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
    return document;
  }

  Future<void> _setupWelcomeDocument(PrivilegeLevelRequired privilegeLevelRequired) async {
    return await AbstractRepositorySingleton.singleton
        .documentRepository(installApp.appId)
        .add(_welcomeDocument(privilegeLevelRequired));
  }
*/




  Future<void> _storeBookletModel(PrivilegeLevelRequired privilegeLevelRequired) async {
    return await AbstractRepositorySingleton.singleton
        .bookletRepository(installApp.appId)
        .add(_welcomeBooklet(privilegeLevelRequired));
  }

  BookletModel _welcomeBooklet(PrivilegeLevelRequired privilegeLevelRequired) {
    List<SectionModel> entries = List();
    {
      entries.add(SectionModel(
          documentID: "1",
          title: "Welcome",
          description: _welcomePageContents(privilegeLevelRequired),
          links: null));
    }

    return BookletModel(
      documentID: IDENTIFIERs[privilegeLevelRequired.index],
      name: "About",
      sections: entries,
      appId: installApp.appId,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }




  // ************************ Tutorials *****************
  Future<List<PageModel>> run() async {
    await WhoImages(newAppTools).run();
//    var appMenu = await installApp.appBarMenu("Welcome", adminMenu);
    var appBar =
        await installApp.appBar(APP_BAR_IDENTIFIER, adminMenu, "Welcome");
    await _setupFader();
    List<PageModel> pages = [];
    for (int i = 0; i < IDENTIFIERs.length; i++) {
      await _storeBookletModel(privilegeLevelsRequired[i]);
      pages.add(await _setupPage(appBar, privilegeLevelsRequired[i]));
    }
    return pages;
  }
}
