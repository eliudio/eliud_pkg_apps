import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/dynamic_helper.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/document_component.dart';
import 'package:eliud_pkg_fundamentals/model/document_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/document_model.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'images.dart';

class Welcome extends AppSection {
  Welcome({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "welcome";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp.appId).add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "2", componentName: AbstractFaderComponent.componentName, componentId: FADER_IDENTIFIER));
    components.add(BodyComponentModel(
        documentID: "3", componentName: AbstractDividerComponent.componentName, componentId: "divider_1"));
    components.add(BodyComponentModel(
        documentID: "4", componentName: AbstractDocumentComponent.componentName, componentId: WELCOME_IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: MinkeyApp.MINKEY_APP_ID,
        title: "Welcome",
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

  Future<void> _setupFader() async {
    return await AbstractRepositorySingleton.singleton.faderRepository(installApp.appId).add(_fader());
  }

  static String FADER_IDENTIFIER = IDENTIFIER;
  FaderModel _fader() {
      List<ListedItemModel> items = List();
      items.add(
          ListedItemModel(
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
          appId: MinkeyApp.MINKEY_APP_ID,
      );
      return model;
  }

  String _welcomePageContents() {
    List<SectionSpec> sections = List();
    {
      sections.add(SectionSpec("Hello!",
          "Welcome to Minkey"),);
    }

    PageSpec pageSpec = PageSpec(sections);

    return DynamicHelper.getPage(pageSpec);
  }

  static String WELCOME_IDENTIFIER = "welcome";
  DocumentModel _welcomeDocument() {
    List<DocumentItemModel> list = List();
    DocumentModel document = DocumentModel(
        documentID: WELCOME_IDENTIFIER,
        name: "First document",
        content: _welcomePageContents(),
        documentRenderer: DocumentRenderer.dynamic_widget,
        appId: MinkeyApp.MINKEY_APP_ID,
        images: list,
        padding: 10);
    return document;
  }

  Future<void> _setupWelcomeDocument() async {
    return await AbstractRepositorySingleton.singleton.documentRepository(installApp.appId).add(_welcomeDocument());
  }

  // ************************ Tutorials *****************
  Future<PageModel> run() async {
    await WhoImages(newAppTools).run();
//    var appMenu = await installApp.appBarMenu("Welcome", adminMenu);
    var appBar = await installApp.appBar(WELCOME_IDENTIFIER, adminMenu, "Welcome");
    await _setupWelcomeDocument();
    await _setupFader();
    return await _setupPage(appBar);
  }
}
