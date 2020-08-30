import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/hello_world/hello_world.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
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

import '../../app_base.dart';
import '../eliud_app.dart';
import '../../app_section.dart';
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

  static String IDENTIFIER = "welcome";

  Future<PageModel> _setupPage(AppBarModel appBar) {
    return corerepo.AbstractRepositorySingleton.singleton
        .pageRepository()
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "2",
        componentName: AbstractFaderComponent.componentName,
        componentId: FADER_IDENTIFIER));
    components.add(BodyComponentModel(
        documentID: "3", componentName: AbstractDividerComponent.componentName, componentId: "divider_1"));
    components.add(BodyComponentModel(
        documentID: "4",
        componentName: AbstractDocumentComponent.componentName,
        componentId: WELCOME_IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: EliudApp.ELIUD_APP_ID,
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
    return AbstractRepositorySingleton.singleton
        .faderRepository()
        .add(_fader());
  }

  static String FADER_IDENTIFIER = IDENTIFIER;
  FaderModel _fader() {
    List<ListedItemModel> items = List();
    items.add(ListedItemModel(
        documentID: "android",
        description: "Android",
        posSize: installApp.screen75(),
        image: newAppTools.findImageModel("android")));
    items.add(ListedItemModel(
        documentID: "macbook",
        description: "Macbook",
        posSize: installApp.screen75(),
        image: newAppTools.findImageModel("macbook")));
    items.add(ListedItemModel(
        documentID: "iphone",
        description: "iphone",
        posSize: installApp.screen75(),
        image: newAppTools.findImageModel("iphone")));
    items.add(ListedItemModel(
        documentID: "tablet",
        description: "Tablet",
        posSize: installApp.screen75(),
        image: newAppTools.findImageModel("tablet")));
    FaderModel model = FaderModel(
      documentID: FADER_IDENTIFIER,
      name: "Welcome fader",
      animationMilliseconds: 1000,
      imageSeconds: 5,
      animation: FaderAnimation.Fade,
      items: items,
      appId: EliudApp.ELIUD_APP_ID,
    );
    return model;
  }

  String _welcomePageContents() {
    List<SectionSpec> sections = List();
    {
      sections.add(
        SectionSpec("Hello!",
            "We present to you Eliud. Eliud is a platform to build your multi platform application for Android, iphone, online website, windows, linux and or apple mac."),
      );
    }
    {
      List<LinkSpec> links = List();
      sections.add(SectionSpec("What is Eliud?",
          "Eliud is technology. Eliud is free and open-source technology which enables content management systems to publish web content and/or to build your multi platform application with no code.",
          links: links));
    }
    {
      List<LinkSpec> links = List();
      sections.add(SectionSpec("Why Eliud?",
          "A few reasons to choose eliud. If you want websites, mobile apps or desktop apps that require user accounts and registration. Eliud has a lot of in-built components to present your content, and also allows to buid extentions yourself. Eliud is developed by enthousiastic volunteers.",
          links: links));
    }
    {
      List<LinkSpec> links = List();
      sections.add(SectionSpec("How does it look like?",
          "Websites, apps and applications built with Eliud look like eliud.io, i.e. what you are looking at right now. No code is needed to build this site. Other examples of sites are minkey.io and all other apps avaible from minkey.io.",
          links: links));
    }
    {
      List<LinkSpec> links = List();
      sections.add(SectionSpec(
          "What is minkey and how does it relate to eliud?",
          "Minkey is a platform that allows to build online apps / websites / ... and make them available instantly. Eliud is the technology that makes this possible. Your apps build on minkey.io are instantly available from minkey.io. But, you can as well choose to move your app away from minkey and host it yourself on you own Google account, using the technology provided by eliud. So, try before you commit: try it out on minkey.io. If you like it and want to host it yourself, then come back to eliud.io and follow the instructins to use the technology yourself without the assistance of minkey.io. Minkey.io has the capability to extract all your data from there to move it out and host it yourself. If you like it on minkey.io then that's obviously fine as well. Enjoy ;-)!",
          links: links));
    }
    {
      List<LinkSpec> links = List();
      links.add(LinkSpec("Hello World", HelloWorld.IDENTIFIER));
      sections.add(SectionSpec("How to get started with Eliud?",
          "Follow the below links... Start with hello world",
          links: links));
    }
    {
      List<LinkSpec> links = List();
      links.add(LinkSpec("Who", AboutBase.identifier));
      sections.add(SectionSpec("Who's involved?",
          "Follow the below link to find out who's building this platform... ",
          links: links));
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
        images: list,
        appId: EliudApp.ELIUD_APP_ID,
        padding: 10);
    return document;
  }

  Future<void> _setupWelcomeDocument() {
    return AbstractRepositorySingleton.singleton
        .documentRepository()
        .add(_welcomeDocument());
  }

  // ************************ Tutorials *****************
  Future<PageModel> run() async {
    await WhoImages(newAppTools).run();
    var appMenu = await installApp.appBarMenu("Basket", adminMenu);
    var appBar = await installApp.appBar(
        WELCOME_IDENTIFIER,
        appMenu,
        "Welcome");
    await _setupWelcomeDocument();
    await _setupFader();
    return await _setupPage(appBar);
  }
}
