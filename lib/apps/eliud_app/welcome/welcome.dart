import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
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
import '../eliud_app.dart';

const String welcomeText = """
Hello!\n\n
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
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository().add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
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
        conditional: PageCondition.Always,
        bodyComponents: components);
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
    await AbstractRepositorySingleton.singleton.bookletRepository().add(_welcome());
  }

  Future<PageModel> run() async {
    var appBar = await installApp.appBar(identifier, adminMenu, "Welcome");
    await _setupWelcome();
    return await _setupPage(appBar);
  }
}
