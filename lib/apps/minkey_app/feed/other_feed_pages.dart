import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile_component.dart';
import 'package:eliud_pkg_apps/apps/shared/follow/follow_dashboards.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
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
import 'package:eliud_pkg_follow/model/follow_requests_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/invite_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'example_posts.dart';
import 'feed_menu.dart';
import 'header_component.dart';

class OtherFeedPages extends AppSection {
  OtherFeedPages(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      BackgroundModel? pageBG,
      DrawerModel? drawer,
      DrawerModel? endDrawer,
      MenuDefModel? adminMenu})
      : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  Future<PageModel> _setupPage(AppBarModel appBar, String componentName, String identifier, String title) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.appId)!
        .add(_page(appBar, componentName, identifier, title));
  }

  PageModel _page(AppBarModel appBar, String componentName, String identifier, String title) {
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
        componentName: componentName,
        componentId: identifier));

    return PageModel(
        documentID: identifier,
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

  Future<PageModel> doIt(String componentName, String identifier, String title) async {
    var appBar = await installApp!.appBar(identifier, adminMenu, title);
    return await _setupPage(appBar, componentName, identifier, title);
  }

  Future<void> run() async {
    await doIt(AbstractFollowingDashboardComponent.componentName, FollowDashboards.FOLLOWERS_IDENTIFIER, "Followers");
    await doIt(AbstractFollowingDashboardComponent.componentName, FollowDashboards.FOLLOWING_IDENTIFIER, "Following");
    await doIt(AbstractFollowRequestsDashboardComponent.componentName, FollowRequestDashboard.FOLLOW_REQUEST_IDENTIFIER, "Follow requests");
    await doIt(AbstractInviteDashboardComponent.componentName, InviteDashboard.INVITE_IDENTIFIER, "Find Friends");
    await doIt(AbstractMembershipDashboardComponent.componentName, MembershipDashboard.IDENTIFIER, "App Members");
  }
}