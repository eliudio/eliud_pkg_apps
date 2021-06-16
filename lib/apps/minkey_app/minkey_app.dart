import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/default_style/eliud_style.dart';
import 'package:eliud_core/default_style/instances/eliud_minkey_style.dart';
import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_home_page_references_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/notifications/minkey_notification_dashboard.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/store/play_store.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/workflow/workflow_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/about/founders/founders.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/assignments/assignment_view_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_model.dart';
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:flutter/material.dart';

import '../app_base.dart';
import 'about/about.dart';
import 'admin/admin.dart';
import 'album/album.dart';
import 'assignments/minkey_assignments.dart';
import 'blocked/minkey_blocked.dart';
import 'feed/feed.dart';
import 'feed/other_feed_pages.dart';
import 'feed/profile.dart';
import 'follow/follow_dashboards.dart';
import 'member/minkey_member_dashboard.dart';
import 'membership/minkey_membership_dashboard.dart';

/* This code cleans the database and generates the minkey app, which includes the admin pages
 */
class MinkeyApp extends InstallApp {
  static String MINKEY_APP_ID = "MINKEY_APP";

  MinkeyApp()
      : super(
            appId: MINKEY_APP_ID,
            );

  @override
  MenuDefModel profileDrawerMenuDef() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Other apps",
        description: "Other apps",
        action: InternalAction(appId,
            internalActionEnum: InternalActionEnum.OtherApps)));
    menuItems.add(menuItemSignOut(appId, "2"));
    menuItems.add(menuItemFlushCache(appId, "3"));
    menuItems.add(menuItemManageAccount(appId, "4", MemberDashboard.IDENTIFIER));

    MenuDefModel menu = MenuDefModel(
        documentID: "drawer_profile_menu",
        appId: MINKEY_APP_ID,
        name: "Drawer Profile Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  MenuDefModel drawerMenuDef() {
    MenuDefModel _homeMenuDef = homeMenuDef();
    var drawerMenuItems = _homeMenuDef.menuItems!;
    drawerMenuItems.addAll(getPolicyMenuItems());
    MenuDefModel drawerMenu = _homeMenuDef.copyWith(
        documentID: "drawer_menu", name: "Drawer Menu (copy of main menu)",
        menuItems: drawerMenuItems
    );
    return drawerMenu;
  }

  @override
  MenuDefModel homeMenuDef() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(menuItemFeed(appId, "feed", Feed.IDENTIFIER, "Feed"));
    menuItems.add(menuItem(
        appId, "apps", PlayStore.IDENTIFIER, "Apps", Icons.power_settings_new));
    for (int i = 0; i < Welcome.IDENTIFIERs.length; i++) {
      menuItems.add(menuItemWelcome(
          appId, Welcome.IDENTIFIERs[i], Welcome.IDENTIFIERs[i], "Welcome"));
    }
    menuItems.add(menuItemAbout(appId, "about", Founders.IDENTIFIER, "About"));
    menuItems.add(menuItem(appId, "album", Album.IDENTIFIER, "Album", Icons.photo));
    MenuDefModel menu = MenuDefModel(
        documentID: "main",
        appId: MINKEY_APP_ID,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<AppModel> setupApplication(AppHomePageReferencesModel homePages,
      String? ownerID, MemberMediumModel? logo) async {
    AppModel application = AppModel(
      documentID: MINKEY_APP_ID,
      title: "Minkey!",
      description: "Minkey",
      logo: logo,
      email: "minkey.io.info@gmail.com",
      styleFamily: EliudStyle.eliudFamilyName,
      styleName: EliudMinkeyStyle.styleName,
      homePages: homePages,
      routeBuilder: PageTransitionAnimation.FadeRoute,
      routeAnimationDuration: 800,
      ownerID: ownerID,
      appStatus: AppStatus.Live,
      policies: appPolicyModel
    );
    return await AbstractMainRepositorySingleton.singleton
        .appRepository()!
        .update(application);
  }

  @override
  AdminBase adminBase(DrawerModel drawer, DrawerModel endDrawer) => Admin(
      installApp: this,
      homeMenu: homeMenu(),
      drawer: drawer,
      endDrawer: endDrawer);

  @override
  List<AdminAppWiperBase> adminAppWipers() {
    return [
      coreadmin.AdminAppWiper(),
      fundamentals.AdminAppWiper(),
    ];
  }

  @override
  Future<AppHomePageReferencesModel> runTheRest(String? ownerID,
      DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu) async {
    await createPolicyPages(appPolicyModel!, drawer, endDrawer,  adminMenu);
    var member = await AbstractMainRepositorySingleton.singleton
        .memberRepository()!
        .get(ownerID);
    if (member == null) {
      throw Exception("Can not find member");
    } else {
      // await createFollowMenu();
      var homePageLevel1Member = await Feed(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run(member);
      await OtherFeedPages(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run();
      await Profile(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run(member, Feed.feedModel());
      await WorkflowSetup(installApp: this).run();
      await About(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run();
      await Welcome(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run();
      var homePageSubscribedMember = await PlayStore(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run();
      await MinkeyNotificationDashboard(
          installApp: this,
          backgroundColor: EliudColors.gray)
          .run();
      await MinkeyMemberDashboard(
          installApp: this,
          backgroundColor: EliudColors.gray)
          .run();
      await MinkeyMembershipDashboard(
          installApp: this,
          backgroundColor: EliudColors.gray)
          .run();
      await MinkeyAssignmentViewSetup(
          installApp: this,
          backgroundColor: EliudColors.gray)
          .run();
      await MinkeyFollowDashboards(
          installApp: this,
          backgroundColor: EliudColors.gray)
          .run();
      var homePageBlockedMember = await MinkeyBlocked(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run();
      await Album(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run(member);


      AppHomePageReferencesModel homePages = AppHomePageReferencesModel(
        homePageBlockedMemberId: homePageBlockedMember.documentID,
        homePageSubscribedMemberId: homePageSubscribedMember.documentID,
        homePageLevel1MemberId: homePageLevel1Member.documentID,
      );
      return homePages;
    }
  }

  /*
  static String FOLLOW_MENU_ID = "followMenu";
  MenuDefModel followMenu() {
    var menuItems = <MenuItemModel>[
      menuItemFollowRequests(appId, "1", FollowRequestDashboard.FOLLOW_REQUEST_IDENTIFIER),
      menuItemFollowers(appId, "2", FollowDashboards.FOLLOWERS_IDENTIFIER, PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFollowing(appId, "3", FollowDashboards.FOLLOWING_IDENTIFIER, PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFiendFriends(appId, "4", InviteDashboard.INVITE_IDENTIFIER, PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemAppMembers(appId, "5", MembershipDashboard.IDENTIFIER, PrivilegeLevelRequired.NoPrivilegeRequired),
    ];
    MenuDefModel menu = MenuDefModel(
        documentID: "followMenu",
        appId: MINKEY_APP_ID,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> createFollowMenu() async {
    return await AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)!
        .add(followMenu());
  }*/

  Future<void> run(String ownerID) async {
    return await runBase(
        ownerID: ownerID);
  }

  @override
  Future<AppBarModel> appBar(
      String? identifier, MenuDefModel? menu, String? title) async {
    return await setupAppBar(
        identifier,
        menu,
        title,
        );
  }

  @override
  List<MenuItemModel> extraMenuItems() => <MenuItemModel>[
    MenuItemModel(
        documentID: 'feed',
        text: 'Post',
        description: 'Post this page to my feed',
        icon: IconModel(
            codePoint: Icons.post_add.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: PostActionModel(
            MinkeyApp.MINKEY_APP_ID,
            feed: Feed.feedModel(),
            conditions: ConditionsModel(
              privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
              packageCondition: CorePackage.MUST_BE_LOGGED_ON
            )
        )),
    MenuItemModel(
        documentID: 'notifications',
        text: 'Notifications',
        description: 'Notifications',
        icon: IconModel(
            codePoint: Icons.notifications.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: OpenDialog(MinkeyApp.MINKEY_APP_ID,
            dialogID: NotificationDashboard.IDENTIFIER)),
    MenuItemModel(
        documentID: 'assignments',
        text: 'Assignments',
        description: 'Assignments',
        icon: IconModel(
            codePoint: Icons.playlist_add_check.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: OpenDialog(MinkeyApp.MINKEY_APP_ID,
            dialogID: AssignmentViewSetup.IDENTIFIER)),
/*
    MenuItemModel(
        documentID: 'member_area',
        text: 'Members area',
        description: 'Members area',
        icon: IconModel(
            codePoint: Icons.favorite_border.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: PopupMenu(MinkeyApp.MINKEY_APP_ID, menuDef: followMenu())),
*/
    MenuItemModel(
        documentID: "join",
        text: "JOIN",
        description: "Request membership",
        icon: null,
        action:
            WorkflowSetup.requestMembershipAction(MinkeyApp.MINKEY_APP_ID))
    ];

  @override
  String logoAssetLocation() => 'packages/eliud_pkg_apps/assets/minkey_app/logos/logo.png';

  @override
  String logoHeadAssetLocation() => 'packages/eliud_pkg_apps/assets/minkey_app/logos/logo_head.png';

  // Policies
  @override
  String privacyPolicyAssetLocation() => 'packages/eliud_pkg_apps/assets/minkey_app/legal/Minkey-Privacy-Policy.pdf';

  @override
  String termsOfServiceAssetLocation() => 'packages/eliud_pkg_apps/assets/minkey_app/legal/Minkey-Terms-of-Service.pdf';

  @override
  String disclaimerAssetLocation() => 'packages/eliud_pkg_apps/assets/minkey_app/legal/Minkey-Disclaimer.pdf';
}
