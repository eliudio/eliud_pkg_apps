/*
import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core_main/model/model_export.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';
import 'feed_menu.dart';
import 'header_component.dart';

class Profile extends AppSection {
  Profile(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer,})
      : super(installApp, homeMenu, drawer, endDrawer, );

  static String identifier = "profile";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractFeedMenuComponent.componentName,
        componentId: FeedMenu.FEED_MENU_ID));
    components.add(BodyComponentModel(
        documentID: "2",
        componentName: AbstractHeaderComponent.componentName,
        componentId: HeaderComponent.HEADER_ID));
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractProfileComponent.componentName,
        componentId: identifier));

    return PageModel(
        documentID: identifier,
        appId: MinkeyApp.minkeyAppId,
        title: "Profile",
        description: "Profile",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.level1PrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  static ProfileModel profileModel(FeedModel feed) {
    return ProfileModel(
      documentID: identifier,
      feed: feed,
      appId: MinkeyApp.minkeyAppId,
      description: "My Profile",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<ProfileModel> _setupProfile(FeedModel feed) async {
    return await AbstractRepositorySingleton.singleton
        .profileRepository(installApp!.theApp.documentID)!
        .add(profileModel(feed));
  }

  Future<PageModel> run(MemberModel member, FeedModel feed) async {
    var appBar = installApp!.appBar();
    await _setupProfile(feed);
    return await _setupPage(appBar);
  }
}
*/
