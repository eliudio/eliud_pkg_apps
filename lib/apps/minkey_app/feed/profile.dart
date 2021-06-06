import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile_component.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'example_posts.dart';
import 'feed_menu.dart';
import 'header_component.dart';

class Profile extends AppSection {
  Profile(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      BackgroundModel? pageBG,
      DrawerModel? drawer,
      DrawerModel? endDrawer,
      MenuDefModel? adminMenu})
      : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "profile";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.appId)!
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
        componentId: IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: MinkeyApp.MINKEY_APP_ID,
        title: "Profile",
        drawer: drawer,
        widgetWrapper: 'profile',
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequired.Level1PrivilegeRequired,
        ),
        bodyComponents: components);
  }

  static ProfileModel profileModel(FeedModel feed) {
    return ProfileModel(
      documentID: IDENTIFIER,
      feed: feed,
      appId: MinkeyApp.MINKEY_APP_ID,
      description: "My Profile",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<ProfileModel> _setupProfile(FeedModel feed) async {
    return await AbstractRepositorySingleton.singleton
        .profileRepository(installApp!.appId)!
        .add(profileModel(feed));
  }

  Future<PageModel> run(MemberModel member, FeedModel feed) async {
    var appBar = await installApp!.appBar(IDENTIFIER, adminMenu, "Profile");
    await _setupProfile(feed);
    return await _setupPage(appBar);
  }
}
