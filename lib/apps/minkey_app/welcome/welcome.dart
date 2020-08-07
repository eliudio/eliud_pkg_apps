import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/dynamic_helper.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_model/component/divider_component.dart';
import 'package:eliud_model/component/document_component.dart';
import 'package:eliud_model/component/document_model.dart';
import 'package:eliud_model/component/document_item_model.dart';
import 'package:eliud_model/component/fader_component.dart';
import 'package:eliud_model/component/fader_model.dart';
import 'package:eliud_model/component/listed_item_model.dart';
import 'package:eliud_model/model/body_component_model.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/page_model.dart';
import 'package:eliud_model/model/app_bar_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_model/shared/abstract_repository_singleton.dart';
import 'package:eliud_model/shared/background_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'images.dart';

class Welcome extends AppSection {
  Welcome({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "welcome";

  Future<PageModel> _setupPage(AppBarModel appBar) {
    return AbstractRepositorySingleton.singleton.pageRepository().add(_page(appBar));
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
        conditional: PageCondition.Always,
        bodyComponents: components);
  }

  Future<void> _setupFader() {
    return AbstractRepositorySingleton.singleton.faderRepository().add(_fader());
  }

  static String FADER_IDENTIFIER = IDENTIFIER;
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
          animation: FaderAnimation.Slide,
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

  Future<void> _setupWelcomeDocument() {
    return AbstractRepositorySingleton.singleton.documentRepository().add(_welcomeDocument());
  }

  // ************************ Tutorials *****************
  Future<PageModel> run() async {
    await WhoImages(newAppTools).run();
    var appMenu = await installApp.appBarMenu("Welcome", adminMenu);
    var appBar = await installApp.appBar(WELCOME_IDENTIFIER, appMenu, "Welcome");
    await _setupWelcomeDocument();
    await _setupFader();
    return await _setupPage(appBar);
  }
}
