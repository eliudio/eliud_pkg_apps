import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/tool_set.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/dynamic_helper.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/document_component.dart';
import 'package:eliud_pkg_fundamentals/model/document_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/document_model.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class Welcome extends AppSection {
  Welcome(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer,
      })
      : super(installApp, homeMenu, drawer, endDrawer,
            );

  static List<String> IDENTIFIERs = [
    "welcome_subscribed_member",
    "welcome_member_level1",
    "welcome_member_level2",
    "welcome_owner"
  ];
  static List<PrivilegeLevelRequiredSimple> privilegeLevelsRequired = [
    PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
    PrivilegeLevelRequiredSimple.Level1PrivilegeRequiredSimple,
    PrivilegeLevelRequiredSimple.Level2PrivilegeRequiredSimple,
    PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple
  ];
  static List<PrivilegeLevelRequired> menuPrivilegeLevelsRequired = [
    PrivilegeLevelRequired.NoPrivilegeRequired,
    PrivilegeLevelRequired.Level1PrivilegeRequired,
    PrivilegeLevelRequired.Level2PrivilegeRequired,
    PrivilegeLevelRequired.OwnerPrivilegeRequired
  ];
  static String FADER_IDENTIFIER = 'welcome_fader';
  static String APP_BAR_IDENTIFIER = 'welcome_appbar';

  Future<PageModel> _setupPage(AppBarModel appBar, PrivilegeLevelRequiredSimple privilegeLevelRequired) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID!)!
        .add(_page(appBar, privilegeLevelRequired));
  }

  PageModel _page(AppBarModel appBar, PrivilegeLevelRequiredSimple privilegeLevelRequired) {
    List<BodyComponentModel> components = [];
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
        componentName: AbstractDocumentComponent.componentName,
        componentId: IDENTIFIERs[privilegeLevelRequired.index]));

    return PageModel(
        documentID: IDENTIFIERs[privilegeLevelRequired.index],
        appId: MinkeyApp.MINKEY_APP_ID,
        title: "Welcome",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            ),
        bodyComponents: components);
  }

  Future<FaderModel> _setupFader(PlatformMediumModel android, PlatformMediumModel iphone, PlatformMediumModel tablet, PlatformMediumModel macbook, ) async {
    return await AbstractRepositorySingleton.singleton
        .faderRepository(installApp!.theApp.documentID!)!
        .add(_fader(android, iphone, tablet, macbook, ));
  }

  Future<PlatformMediumModel> androidImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/android.jpg');
  }

  Future<PlatformMediumModel> iphoneImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/iphone.jpg');
  }

  Future<PlatformMediumModel> tabletImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/tablet.jpg');
  }

  Future<PlatformMediumModel> macbookImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.theApp, installApp!.member!, 'packages/eliud_pkg_apps/assets/minkey_app/devices/macbook.jpg');
  }

  FaderModel _fader(PlatformMediumModel android, PlatformMediumModel iphone, PlatformMediumModel tablet, PlatformMediumModel macbook, ) {
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
      documentID: FADER_IDENTIFIER,
      name: "Welcome fader",
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: MinkeyApp.MINKEY_APP_ID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
    return model;
  }

  String _welcomePageContents(PrivilegeLevelRequiredSimple privilegeLevelRequired) {
    var privilegeLevelString = privilegeLevelIntToMemberRoleString(privilegeLevelRequired.index, false);
    List<SectionSpec> sections = [];
    {
      sections.add(
        SectionSpec(
            "Hello!",
            "Welcome back to Minkey. This is a page demonstrating with dynamic widgets. " +
                ((privilegeLevelRequired.index == 0)
                    ? "You are not yet registered. Why not JOIN?"
                    : "You are registered as $privilegeLevelString")),
      );
    }

    PageSpec pageSpec = PageSpec(sections);

    return DynamicHelper.getPage(pageSpec);
  }

  DocumentModel _welcomeDocument(PrivilegeLevelRequiredSimple privilegeLevelRequired) {
    List<DocumentItemModel> list = [];
    DocumentModel document = DocumentModel(
        documentID: IDENTIFIERs[privilegeLevelRequired.index],
        name: "First document",
        content: _welcomePageContents(privilegeLevelRequired),
        documentRenderer: DocumentRenderer.dynamic_widget,
        appId: MinkeyApp.MINKEY_APP_ID,
        images: list,
        padding: 10,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
    return document;
  }

  Future<DocumentModel> _setupWelcomeDocument(PrivilegeLevelRequiredSimple privilegeLevelRequired) async {
    return await AbstractRepositorySingleton.singleton
        .documentRepository(installApp!.theApp.documentID!)!
        .add(_welcomeDocument(privilegeLevelRequired));
  }

  // ************************ Tutorials *****************
  Future<void> run() async {
    var appBar =
        await installApp!.appBar();
    var android = await androidImage();
    var iphone = await iphoneImage();
    var tablet = await tabletImage();
    var macbook = await macbookImage();

    await _setupFader(android, iphone, tablet, macbook);
    for (int i = 0; i < IDENTIFIERs.length; i++) {
      await _setupWelcomeDocument(privilegeLevelsRequired[i]);
      await _setupPage(appBar, privilegeLevelsRequired[i]);
    }
    return;
  }
}
