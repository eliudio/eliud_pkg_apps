import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core/tools/tool_set.dart';
import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/display_conditions_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/platform_medium_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals_model/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/document_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/document_item_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/document_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/listed_item_model.dart';
import 'package:eliud_pkg_shop/wizards/builders/util/image_tools.dart';

import '../../install_app.dart';
import '../../app_section.dart';

class Welcome extends AppSection {
  Welcome({
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  static List<String> theIdentifiers = [
    "welcome_subscribed_member",
    "welcome_member_level1",
    "welcome_member_level2",
    "welcome_owner"
  ];
  static List<PrivilegeLevelRequiredSimple> privilegeLevelsRequired = [
    PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
    PrivilegeLevelRequiredSimple.level1PrivilegeRequiredSimple,
    PrivilegeLevelRequiredSimple.level2PrivilegeRequiredSimple,
    PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple
  ];
  static List<PrivilegeLevelRequired> menuPrivilegeLevelsRequired = [
    PrivilegeLevelRequired.noPrivilegeRequired,
    PrivilegeLevelRequired.level1PrivilegeRequired,
    PrivilegeLevelRequired.level2PrivilegeRequired,
    PrivilegeLevelRequired.ownerPrivilegeRequired
  ];
  static String faderIdentifier = 'welcome_fader';
  static String appBarIdentifier = 'welcome_appbar';

  Future<PageModel> _setupPage(AppBarModel appBar,
      PrivilegeLevelRequiredSimple privilegeLevelRequired) async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar, privilegeLevelRequired));
  }

  PageModel _page(
      AppBarModel appBar, PrivilegeLevelRequiredSimple privilegeLevelRequired) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "2",
        componentName: AbstractFaderComponent.componentName,
        componentId: faderIdentifier));
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractDividerComponent.componentName,
        componentId: "divider_1"));
    components.add(BodyComponentModel(
        documentID: "4",
        componentName: AbstractDocumentComponent.componentName,
        componentId: theIdentifiers[privilegeLevelRequired.index]));

    return PageModel(
        documentID: theIdentifiers[privilegeLevelRequired.index],
        appId: MinkeyApp.minkeyAppId,
        title: "Welcome",
        description: "Welcome",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: privilegeLevelRequired,
        ),
        bodyComponents: components);
  }

  Future<FaderModel> _setupFader(
    PlatformMediumModel android,
    PlatformMediumModel iphone,
    PlatformMediumModel tablet,
    PlatformMediumModel macbook,
  ) async {
    return await AbstractRepositorySingleton.singleton
        .faderRepository(installApp!.theApp.documentID)!
        .add(_fader(
          android,
          iphone,
          tablet,
          macbook,
        ));
  }

  Future<PlatformMediumModel> androidImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!.documentID,
        'packages/eliud_pkg_apps/assets/minkey_app/devices/android.jpg',
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  Future<PlatformMediumModel> iphoneImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!.documentID,
        'packages/eliud_pkg_apps/assets/minkey_app/devices/iphone.jpg',
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  Future<PlatformMediumModel> tabletImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!.documentID,
        'packages/eliud_pkg_apps/assets/minkey_app/devices/tablet.jpg',
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  Future<PlatformMediumModel> macbookImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!.documentID,
        'packages/eliud_pkg_apps/assets/minkey_app/devices/macbook.jpg',
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  FaderModel _fader(
    PlatformMediumModel android,
    PlatformMediumModel iphone,
    PlatformMediumModel tablet,
    PlatformMediumModel macbook,
  ) {
    List<ListedItemModel> items = [];
    items.add(ListedItemModel(
        documentID: "android",
        description: "Android",
        posSize: installApp!.halfScreen(),
        image: android));
    items.add(ListedItemModel(
        documentID: "macbook",
        description: "Macbook",
        posSize: installApp!.halfScreen(),
        image: macbook));
    items.add(ListedItemModel(
        documentID: "iphone",
        description: "iphone",
        posSize: installApp!.halfScreen(),
        image: iphone));
    items.add(ListedItemModel(
        documentID: "tablet",
        description: "Tablet",
        posSize: installApp!.halfScreen(),
        image: tablet));
    FaderModel model = FaderModel(
      documentID: faderIdentifier,
      description: "Welcome fader",
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: MinkeyApp.minkeyAppId,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    return model;
  }

  String _welcomePageContents(
      PrivilegeLevelRequiredSimple privilegeLevelRequired) {
    var privilegeLevelString = privilegeLevelIntToMemberRoleString(
        privilegeLevelRequired.index, false);
    return "Hello! Welcome to Minkey. ${(privilegeLevelRequired.index == 0) ? "You are not yet registered. Why not JOIN?" : "You are registered as $privilegeLevelString"}";
  }

  DocumentModel _welcomeDocument(
      PrivilegeLevelRequiredSimple privilegeLevelRequired) {
    List<DocumentItemModel> list = [];
    DocumentModel document = DocumentModel(
      documentID: theIdentifiers[privilegeLevelRequired.index],
      description: "First document",
      content: _welcomePageContents(privilegeLevelRequired),
      appId: MinkeyApp.minkeyAppId,
      images: list,
      padding: 10,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    return document;
  }

  Future<DocumentModel> _setupWelcomeDocument(
      PrivilegeLevelRequiredSimple privilegeLevelRequired) async {
    return await AbstractRepositorySingleton.singleton
        .documentRepository(installApp!.theApp.documentID)!
        .add(_welcomeDocument(privilegeLevelRequired));
  }

  // ************************ Tutorials *****************
  Future<void> run() async {
    var appBar = installApp!.appBar();
    var android = await androidImage();
    var iphone = await iphoneImage();
    var tablet = await tabletImage();
    var macbook = await macbookImage();

    await _setupFader(android, iphone, tablet, macbook);
    for (int i = 0; i < theIdentifiers.length; i++) {
      await _setupWelcomeDocument(privilegeLevelsRequired[i]);
      await _setupPage(appBar, privilegeLevelsRequired[i]);
    }
    return;
  }
}
