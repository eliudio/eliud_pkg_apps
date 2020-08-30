import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/link_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/hello_world/pages.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_base.dart';
import '../eliud_app.dart';
import '../../app_section.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'menus.dart';
import 'images.dart';


class HelloWorld extends AppSection {
  HelloWorld({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  BookletModel _helloWorldDocument() {
    List<SectionModel> entries = List();
    {
      List<LinkModel> links = List();
      entries.add(SectionModel(
          documentID: "Welcome",
          title: "Welcome",
          description: "On these pages we will guide you through the process of installing your first Hello World Eliud Android App, iPhone App and / or Web App",
          image: null,
          links: links
      ));
    }
    {
      List<LinkModel> links = List();
      links.add(LinkModel(
          documentID: "1.1",
          linkText: "1.1. Create Google Account",
          action: GotoPage(pageID: HelloWorldPages.CREATE_GOOGLE_ACCOUNT)
      ));
      links.add(LinkModel(
          documentID: "1.2",
          linkText: "1.2. Create Firebase Project",
          action: GotoPage(pageID: HelloWorldPages.CREATE_FIREBASE_PROJECT)
      ));
      links.add(LinkModel(
          documentID: "1.3",
          linkText: "1.3. Setup Database",
          action: GotoPage(pageID: HelloWorldPages.CREATE_DATABASE)
      ));
      links.add(LinkModel(
          documentID: "1.4",
          linkText: "1.4. Setup Storage",
          action: GotoPage(pageID: HelloWorldPages.CREATE_STORAGE)
      ));
      links.add(LinkModel(
          documentID: "1.5",
          linkText: "1.5. Setup Authentication",
          action: GotoPage(pageID: HelloWorldPages.CREATE_AUTHENTICATION)
      ));

      entries.add(SectionModel(
          documentID: "2",
          title: "1. Prepare",
          description: "Before anything else, we need to setup Firebase. For this we need a google account, a firebase project and we need to configure the firebase database and storage. Follow these links to do so.",
          image: null,
          links: links
      ));
    }
    {
      List<LinkModel> links = List();
      entries.add(SectionModel(
          documentID: "2.",
          title: "2. Install App",
          description: "Ones we have prepared Google Cloud Platform for our first App, we can go ahead and create the App. Chose your favourite platform from the list below. Obviously you can chose all platforms. We will configure all apps to use the same google cloud account, hence the apps can run side by side, providing exactly the same functionality, on the different devices.",
          image: null,
          links: links
      ));
    }
    {
      List<LinkModel> links = List();
      links.add(LinkModel(
          documentID: "2.1.1",
          linkText: "2.1.1. Create Visual Studio Flutter project for Android App",
          action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_PROJECT)
      ));
      links.add(LinkModel(
          documentID: "2.1.2",
          linkText: "2.1.2 Create Firebase Android App",
          action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)
      ));
      entries.add(SectionModel(
          documentID: "2.1",
          title: "2.1. Install Android App",
          description: "Install your first Eliud Android App.",
          image: null,
          links: links
      ));
    }
    {
      List<LinkModel> links = List();
      links.add(LinkModel(
          documentID: "2.2.1",
          linkText: "2.2.1. Create Visual Studio Flutter project for iPhone App",
          action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_PROJECT)
      ));
      links.add(LinkModel(
          documentID: "2.2.2",
          linkText: "2.2.2 Create Firebase iPhone App",
          action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)
      ));
      entries.add(SectionModel(
          documentID: "2.2",
          title: "2.2. Install iPhone App",
          description: "Install your first Eliud iPhone App.",
          image: null,
          links: links
      ));
    }
    {
      List<LinkModel> links = List();
      links.add(LinkModel(
          documentID: "2.3.1",
          linkText: "2.3.1 Create Firebase Web App",
          action: GotoPage(pageID: HelloWorldPages.CREATE_WEB_APP)
      ));
      links.add(LinkModel(
          documentID: "2.3.2",
          linkText: "2.3.2. Create Visual Studio Flutter project for Web App",
          action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_WEBPROJECT)
      ));
      links.add(LinkModel(
          documentID: "2.3.3",
          linkText: "2.3.3 Deploy your Web App",
          action: GotoPage(pageID: HelloWorldPages.DEPLOY_WEB_APP)
      ));
      entries.add(SectionModel(
          documentID: "2.3",
          title: "2.3. Install Web App",
          description: "Install your first Eliud Web App.",
          image: null,
          links: links
      ));
    }
    {
      List<LinkModel> links = List();
      links.add(LinkModel(
          documentID: "3.1",
          linkText: "3.1 Add a page",
          action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)
      ));
      links.add(LinkModel(
          documentID: "3.2",
          linkText: "3.2 Add a drawer",
          action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)
      ));
      links.add(LinkModel(
          documentID: "3.3",
          linkText: "3.3 Add a home menu",
          action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)
      ));
      links.add(LinkModel(
          documentID: "3.4",
          linkText: "3.4 Add an app bar",
          action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)
      ));
      entries.add(SectionModel(
          documentID: "3",
          title: "3. Configure your app",
          description: "Now it's time to configure your app and add some content",
          image: null,
          links: links
      ));
    }

    return BookletModel(
        documentID: "hello_world",
        name: "Hello world",
        sections:entries,
        appId: EliudApp.ELIUD_APP_ID
    );
  }

  Future<void> _storeHelloWorldDocument() {
    return AbstractRepositorySingleton.singleton.bookletRepository().add(_helloWorldDocument());
  }

  static String IDENTIFIER = "hello_world";

  PageModel helloWorldPage(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(documentID: "1", componentName: AbstractBookletComponent.componentName, componentId: "hello_world"));

    return PageModel(
      documentID: IDENTIFIER,
      appId: EliudApp.ELIUD_APP_ID,
      title: "Hello World",
      drawer: drawer,
      endDrawer: endDrawer,
      background: pageBG,
      appBar: appBar,
      homeMenu: homeMenu,
      layout: PageLayout.OnlyTheFirstComponent,
      bodyComponents: components,
      conditional: PageCondition.Always,
    );
  }

  Future<void> _storeHelloWorldPage(AppBarModel appBar) {
    return corerepo.AbstractRepositorySingleton.singleton.pageRepository().add(helloWorldPage(appBar));
  }

  Future<void> store(AppBarModel appBar) {
    return
      _storeHelloWorldDocument().then((value) =>
      _storeHelloWorldPage(appBar));
  }

  Future<void> run() async {
    var helloWorldMenuValue = await HelloWorldMenu().run(adminMenu);
    var appBar = await installApp.appBar(IDENTIFIER, helloWorldMenuValue, "Hello World");
    await store(appBar);
    await HelloWorldImages(newAppTools).run();
    await HelloWorldPages(newAppTools, appBar, homeMenu, pageBG, drawer, endDrawer).run();
  }
}
