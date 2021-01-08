import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
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
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import '../eliud_app.dart';
import 'images.dart';

const String welcomeText = """
We present to you Eliud. Eliud is a platform to build your multi platform application for Android, iphone, online website, windows, linux and or apple mac.\n\n
Eliud is technology. Eliud is free and open-source technology which enables content management systems to publish web content and/or to build your multi platform application with no code.\n\n
Why Eliud?\n\n
A few reasons to choose eliud. If you want websites, mobile apps or desktop apps that require user accounts and registration. Eliud has a lot of in-built components to present your content, and also allows to buid extentions yourself. Eliud is developed by enthousiastic volunteers.\n\n
How does it look like?\n\n
Websites, apps and applications built with Eliud look like eliud.io, i.e. what you are looking at right now. No code is needed to build this site. Other examples of sites are minkey.io and all other apps avaible from minkey.io.\n\n
What is minkey and how does it relate to eliud?\n\n
Minkey is a platform that allows to build online apps / websites / ... and make them available instantly. Eliud is the technology that makes this possible. Your apps build on minkey.io are instantly available from minkey.io. But, you can as well choose to move your app away from minkey and host it yourself on you own Google account, using the technology provided by eliud. So, try before you commit: try it out on minkey.io. If you like it and want to host it yourself, then come back to eliud.io and follow the instructins to use the technology yourself without the assistance of minkey.io. Minkey.io has the capability to extract all your data from there to move it out and host it yourself. If you like it on minkey.io then that's obviously fine as well. Enjoy ;-
""";

class Welcome extends AppSection {
  Welcome({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String identifier = "welcome";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(EliudApp.ELIUD_APP_ID).add(_page(appBar));
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
        documentID: "4", componentName: AbstractBookletComponent.componentName, componentId: welcomeIdentifier));

    return PageModel(
        documentID: identifier,
        appId: EliudApp.ELIUD_APP_ID,
        title: "Welcome",
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired
        ),
        bodyComponents: components);
  }
  Future<void> _setupFader() {
    return AbstractRepositorySingleton.singleton
        .faderRepository(EliudApp.ELIUD_APP_ID)
        .add(_fader());
  }

  static String FADER_IDENTIFIER = "welcome_fader";
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
      items: items,
      appId: EliudApp.ELIUD_APP_ID,
    );
    return model;
  }

  static String welcomeIdentifier = "welcome";

  BookletModel _welcome() {
    List<SectionModel> entries = List();
    {
      entries.add(SectionModel(
          documentID: "1",
          title: "Hello hello!",
          description: welcomeText,
          image: null,
/*
          imagePositionRelative: RelativeImagePosition.Aside,
          imageAlignment: SectionImageAlignment.Right,
          imageWidth: .33,
*/
          links: List()));
    }

    return BookletModel(
      documentID: welcomeIdentifier,
      name: "Welcome",
      sections:entries,
      appId: installApp.appId,
    );
  }

  Future<void> _setupWelcome() async {
    await AbstractRepositorySingleton.singleton.bookletRepository(EliudApp.ELIUD_APP_ID).add(_welcome());
  }

  Future<PageModel> run() async {
    await WelcomeImages(newAppTools).run();
    var appBar = await installApp.appBar(identifier, adminMenu, "Welcome");
    await _setupWelcome();
    await _setupFader();
    return await _setupPage(appBar);
  }
}
