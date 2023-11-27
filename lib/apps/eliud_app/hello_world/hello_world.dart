import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart';
import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/hello_world/pages.dart';
import 'package:eliud_pkg_fundamentals_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals_model/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/link_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/section_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';
import '../eliud_app.dart';
import 'menus.dart';

class HelloWorld extends AppSection {
  HelloWorld(
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

  BookletModel _helloWorldDocument() {
    List<SectionModel> entries = [];
    {
      List<LinkModel> links = [];
      entries.add(SectionModel(
          documentID: "Welcome",
          title: "Welcome",
          description:
              "On these pages we will guide you through the process of installing your first Hello World Eliud Android App, iPhone App and / or Web App",
          image: null,
          links: links));
    }
    {
      List<LinkModel> links = [];
      links.add(LinkModel(
          documentID: "1.1",
          linkText: "1.1. Create Google Account",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createGoogleAccount)));
      links.add(LinkModel(
          documentID: "1.2",
          linkText: "1.2. Create Firebase Project",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createFirebaseProject)));
      links.add(LinkModel(
          documentID: "1.3",
          linkText: "1.3. Setup Database",
          action:
              GotoPage(EliudApp.app, pageID: HelloWorldPages.createDatabase)));
      links.add(LinkModel(
          documentID: "1.4",
          linkText: "1.4. Setup Storage",
          action:
              GotoPage(EliudApp.app, pageID: HelloWorldPages.createStorage)));
      links.add(LinkModel(
          documentID: "1.5",
          linkText: "1.5. Setup Authentication",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createAuthentication)));

      entries.add(SectionModel(
          documentID: "2",
          title: "1. Prepare",
          description:
              "Before anything else, we need to setup Firebase. For this we need a google account, a firebase project and we need to configure the firebase database and storage. Follow these links to do so.",
          image: null,
          links: links));
    }
    {
      List<LinkModel> links = [];
      entries.add(SectionModel(
          documentID: "2.",
          title: "2. Install App",
          description:
              "Ones we have prepared Google Cloud Platform for our first App, we can go ahead and create the App. Chose your favourite platform from the list below. Obviously you can chose all platforms. We will configure all apps to use the same google cloud account, hence the apps can run side by side, providing exactly the same functionality, on the different devices.",
          image: null,
          links: links));
    }
    {
      List<LinkModel> links = [];
      links.add(LinkModel(
          documentID: "2.1.1",
          linkText:
              "2.1.1. Create Visual Studio Flutter project for Android App",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createFlutterProject)));
      links.add(LinkModel(
          documentID: "2.1.2",
          linkText: "2.1.2 Create Firebase Android App",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createAndroidApp)));
      entries.add(SectionModel(
          documentID: "2.1",
          title: "2.1. Install Android App",
          description: "Install your first Eliud Android App.",
          image: null,
          links: links));
    }
    {
      List<LinkModel> links = [];
      links.add(LinkModel(
          documentID: "2.2.1",
          linkText:
              "2.2.1. Create Visual Studio Flutter project for iPhone App",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createFlutterProject)));
      links.add(LinkModel(
          documentID: "2.2.2",
          linkText: "2.2.2 Create Firebase iPhone App",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createAndroidApp)));
      entries.add(SectionModel(
          documentID: "2.2",
          title: "2.2. Install iPhone App",
          description: "Install your first Eliud iPhone App.",
          image: null,
          links: links));
    }
    {
      List<LinkModel> links = [];
      links.add(LinkModel(
          documentID: "2.3.1",
          linkText: "2.3.1 Create Firebase Web App",
          action:
              GotoPage(EliudApp.app, pageID: HelloWorldPages.createWebApp)));
      links.add(LinkModel(
          documentID: "2.3.2",
          linkText: "2.3.2. Create Visual Studio Flutter project for Web App",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createFlutterWebProject)));
      links.add(LinkModel(
          documentID: "2.3.3",
          linkText: "2.3.3 Deploy your Web App",
          action:
              GotoPage(EliudApp.app, pageID: HelloWorldPages.deployWebApp)));
      entries.add(SectionModel(
          documentID: "2.3",
          title: "2.3. Install Web App",
          description: "Install your first Eliud Web App.",
          image: null,
          links: links));
    }
    {
      List<LinkModel> links = [];
      links.add(LinkModel(
          documentID: "3.1",
          linkText: "3.1 Add a page",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createAndroidApp)));
      links.add(LinkModel(
          documentID: "3.2",
          linkText: "3.2 Add a drawer",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createAndroidApp)));
      links.add(LinkModel(
          documentID: "3.3",
          linkText: "3.3 Add a home menu",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createAndroidApp)));
      links.add(LinkModel(
          documentID: "3.4",
          linkText: "3.4 Add an app bar",
          action: GotoPage(EliudApp.app,
              pageID: HelloWorldPages.createAndroidApp)));
      entries.add(SectionModel(
          documentID: "3",
          title: "3. Configure your app",
          description:
              "Now it's time to configure your app and add some content",
          image: null,
          links: links));
    }

    return BookletModel(
        documentID: "hello_world",
        description: "Hello world",
        sections: entries,
        appId: EliudApp.eliudAppId,
        conditions: StorageConditionsModel(
            privilegeLevelRequired:
                PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple));
  }

  Future<void> _storeHelloWorldDocument() {
    return bookletRepository(appId: EliudApp.eliudAppId)!
        .add(_helloWorldDocument());
  }

  static String identifier = "hello_world";

  PageModel helloWorldPage(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractBookletComponent.componentName,
        componentId: "hello_world"));

    return PageModel(
      documentID: identifier,
      appId: EliudApp.eliudAppId,
      title: "Hello World",
      description: "Hello World",
      drawer: drawer,
      endDrawer: endDrawer,
      appBar: appBar,
      homeMenu: homeMenu,
      layout: PageLayout.onlyTheFirstComponent,
      bodyComponents: components,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<void> _storeHelloWorldPage(AppBarModel appBar) {
    return pageRepository(appId: EliudApp.eliudAppId)!
        .add(helloWorldPage(appBar));
  }

  Future<void> store(AppBarModel appBar) async {
    await _storeHelloWorldDocument();
    await _storeHelloWorldPage(appBar);
  }

  Future<void> run() async {
    await HelloWorldMenu().run();
    var appBar = installApp!.appBar();
    await store(appBar);
    await HelloWorldPages(appBar, homeMenu, drawer, endDrawer)
        .run(installApp!.member);
  }
}
