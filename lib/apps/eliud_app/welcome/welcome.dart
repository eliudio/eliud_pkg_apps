import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';
import '../eliud_app.dart';

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
  Welcome({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer}) : super(installApp, homeMenu, drawer, endDrawer, );

  static String identifier = "welcome";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(EliudApp.ELIUD_APP_ID)!.add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
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
        description: "Welcome",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
        bodyComponents: components);
  }

  Future<FaderModel> _setupFader(PlatformMediumModel android, PlatformMediumModel iphone, PlatformMediumModel tablet, PlatformMediumModel macbook, ) async {
    return AbstractRepositorySingleton.singleton
        .faderRepository(EliudApp.ELIUD_APP_ID)!
        .add(_fader(android, iphone, tablet, macbook, ));
  }

  Future<PlatformMediumModel> androidImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/android.jpg', PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple);
  }

  Future<PlatformMediumModel> iphoneImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/iphone.jpg', PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple);
  }

  Future<PlatformMediumModel> tabletImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/tablet.jpg', PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple);
  }

  Future<PlatformMediumModel> macbookImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/macbook.jpg', PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple);
  }

  static String FADER_IDENTIFIER = "welcome_fader";
  FaderModel _fader(PlatformMediumModel android, PlatformMediumModel iphone, PlatformMediumModel tablet, PlatformMediumModel macbook, ) {
    List<ListedItemModel> items = [];
    items.add(ListedItemModel(
        documentID: "android",
        description: "Android",
        posSize: installApp!.screen75(),
        image: android));
    items.add(ListedItemModel(
        documentID: "macbook",
        description: "Macbook",
        posSize: installApp!.screen75(),
        image: macbook));
    items.add(ListedItemModel(
        documentID: "iphone",
        description: "iphone",
        posSize: installApp!.screen75(),
        image: iphone));
    items.add(ListedItemModel(
        documentID: "tablet",
        description: "Tablet",
        posSize: installApp!.screen75(),
        image: tablet));
    FaderModel model = FaderModel(
      documentID: FADER_IDENTIFIER,
      description: "Welcome fader",
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: EliudApp.ELIUD_APP_ID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
    return model;
  }

  static String welcomeIdentifier = "welcome";

  BookletModel _welcome() {
    List<SectionModel> entries = [];
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
          links: []));
    }

    return BookletModel(
      documentID: welcomeIdentifier,
      description: "Welcome",
      sections:entries,
      appId: installApp!.theApp.documentID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> _setupWelcome() async {
    await AbstractRepositorySingleton.singleton.bookletRepository(EliudApp.ELIUD_APP_ID)!.add(_welcome());
  }

  Future<PageModel> run() async {
    var android = await androidImage();
    var iphone = await iphoneImage();
    var tablet = await tabletImage();
    var macbook = await macbookImage();

    var appBar = installApp!.appBar();
    await _setupWelcome();
    await _setupFader(android, iphone, tablet, macbook);
    return await _setupPage(appBar);
  }
}
