import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/model/app_home_page_references_model.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core_model/style/frontend/has_drawer.dart';
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
import 'package:eliud_pkg_apps/apps/shared/chat/chat_page.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';
import 'package:eliud_pkg_create/tools/defaults.dart' as defaults;
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:eliud_stl_mona/mona_style_family.dart';
import 'package:flutter/material.dart';

import '../install_app.dart';
import 'about/about.dart';
import 'admin/admin.dart';
import 'album/album.dart';
import 'assignments/minkey_assignments.dart';
import 'blocked/minkey_blocked.dart';
import 'chat/chat_page.dart';
import 'member/minkey_member_dashboard.dart';

/* This code cleans the database and generates the minkey app, which includes the admin pages
 */
class MinkeyApp extends InstallApp {
  static String minkeyAppId = "MINKEY_APP";
  static AppModel app = AppModel(documentID: minkeyAppId, ownerID: '?');

  MinkeyApp()
      : super(
          app,
        );

  @override
  MenuDefModel profileDrawerMenuDef() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Other apps",
        description: "Other apps",
        action: InternalAction(app,
            internalActionEnum: InternalActionEnum.otherApps)));
    menuItems.add(menuItemSignOut(app, "2"));
    menuItems.add(menuItemManageAccount(app, "4", MemberDashboard.identifier));
    menuItems.add(MenuItemModel(
        documentID: "join",
        text: "JOIN",
        description: "Request membership",
        icon: null,
        action: WorkflowSetup.requestMembershipAction()));

    MenuDefModel menu = MenuDefModel(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.right),
        appId: minkeyAppId,
        name: "Drawer Profile Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  MenuDefModel drawerMenuDef() {
    MenuDefModel theHomeMenuDef = homeMenuDef();
    var drawerMenuItems = theHomeMenuDef.menuItems!;
    drawerMenuItems.addAll(getPolicyMenuItems());
    MenuDefModel drawerMenu = theHomeMenuDef.copyWith(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.left),
        name: "Drawer Menu (copy of main menu)",
        menuItems: drawerMenuItems);
    return drawerMenu;
  }

  @override
  MenuDefModel homeMenuDef() {
    List<MenuItemModel> menuItems = [];
//    menuItems.add(menuItemFeed(app, "feed", Feed.identifier, "Feed"));
    menuItems.add(menuItem(
        app, "apps", PlayStore.identifier, "Apps", Icons.power_settings_new));
    for (int i = 0; i < Welcome.theIdentifiers.length; i++) {
      menuItems.add(menuItemWelcome(
          app, Welcome.theIdentifiers[i], Welcome.theIdentifiers[i], "Welcome",
          privilegeLevelRequired: Welcome.menuPrivilegeLevelsRequired[i]));
    }
    menuItems.add(menuItemAbout(app, "about", Founders.identifier2, "About"));
    menuItems
        .add(menuItem(app, "album", Album.identifier, "Album", Icons.photo));
    MenuDefModel menu = MenuDefModel(
        documentID: defaults.homeMenuID(theApp.documentID),
        appId: minkeyAppId,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<AppModel> setupApplication(AppHomePageReferencesModel homePages,
      String ownerID, PublicMediumModel? logo) async {
    AppModel application = AppModel(
      documentID: minkeyAppId,
      title: "Minkey!",
      description: "Minkey",
      logo: logo,
      email: "minkey.io.info@gmail.com",
      styleFamily: MonaStyleFamily.monaStyleFamilyName,
      styleName: MonaStyleFamily.johanStyleName,
      homePages: homePages,
      ownerID: ownerID,
      appStatus: AppStatus.live,
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
  Future<AppHomePageReferencesModel> runTheRest(
      String? ownerID, DrawerModel drawer, DrawerModel endDrawer) async {
    var member = await AbstractMainRepositorySingleton.singleton
        .memberRepository()!
        .get(ownerID);
    if (member == null) {
      throw Exception("Can not find member");
    } else {
      await Album(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run(member);
/*
      var homePageLevel1Member = await Feed(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run(member);
*/
      // await createFollowMenu();
/*
      await OtherFeedPages(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run();
      await Profile(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run(member, Feed.feedModel());
*/
      await WorkflowSetup(installApp: this).run();
      await About(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run();
      await Welcome(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run();
      var homePageSubscribedMember = await PlayStore(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run();
      await MinkeyNotificationDashboard(
        installApp: this,
      ).run();
      await MinkeyMemberDashboard(
        installApp: this,
      ).run();
/*
      await MinkeyMembershipDashboard(
        installApp: this,
      ).run();
*/
      await MinkeyAssignmentViewSetup(installApp: this).run();
/*
      await MinkeyFollowDashboards(
        installApp: this,
      ).run();
*/
      await MinkeyChatPage(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run();
      var homePageBlockedMember = await MinkeyBlocked(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer,
      ).run();

      var homePageLevel1Member = homePageSubscribedMember;

      AppHomePageReferencesModel homePages = AppHomePageReferencesModel(
        homePageBlockedMember: homePageBlockedMember.documentID,
        homePageSubscribedMember: homePageSubscribedMember.documentID,
        homePageLevel1Member: homePageLevel1Member.documentID,
        homePageLevel2Member: homePageLevel1Member.documentID,
        homePagePublic: homePageSubscribedMember.documentID,
      );
      return homePages;
    }
  }

  @override
  Future<void> run(String ownerID) async {
    return await runBase(ownerID: ownerID);
  }

  @override
  List<MenuItemModel> extraMenuItems() => <MenuItemModel>[
/*
        MenuItemModel(
            documentID: 'feed',
            text: 'Post',
            description: 'Post this page to my feed',
            icon: IconModel(
                codePoint: Icons.post_add.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: PostActionModel(app,
                feed: Feed.feedModel(),
                conditions: DisplayConditionsModel(
                    privilegeLevelRequired:
                        PrivilegeLevelRequired.noPrivilegeRequired,
                    packageCondition: CorePackage.MUST_BE_LOGGED_ON))),
*/
        MenuItemModel(
            documentID: 'notifications',
            text: 'Notifications',
            description: 'Notifications',
            icon: IconModel(
                codePoint: Icons.notifications.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: NotificationDashboard.action(app)),
        MenuItemModel(
            documentID: 'assignments',
            text: 'Assignments',
            description: 'Assignments',
            icon: IconModel(
                codePoint: Icons.playlist_add_check.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: AssignmentViewSetup.action(app)),
        MenuItemModel(
            documentID: 'chatUnread',
            text: 'Chat',
            description: 'Open unread chat messages',
            icon: IconModel(
                codePoint: Icons.chat_bubble_rounded.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: ChatPage.unReadAction(app)),
        MenuItemModel(
            documentID: 'chatReadAndUnread',
            text: 'Chat',
            description: 'Open chat',
            icon: IconModel(
                codePoint: Icons.chat_bubble_outline_rounded.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: ChatPage.readAction(app)),
      ];

  @override
  String logoAssetLocation() =>
      'packages/eliud_pkg_apps/assets/minkey_app/logos/logo.png';

  @override
  String logoHeadAssetLocation() =>
      'packages/eliud_pkg_apps/assets/minkey_app/logos/logo_head.png';

  // Policies
  @override
  String privacyPolicyAssetLocation() =>
      'packages/eliud_pkg_apps/assets/minkey_app/legal/Minkey-Privacy-Policy.pdf';

  @override
  String termsOfServiceAssetLocation() =>
      'packages/eliud_pkg_apps/assets/minkey_app/legal/Minkey-Terms-of-Service.pdf';

  @override
  String disclaimerAssetLocation() =>
      'packages/eliud_pkg_apps/assets/minkey_app/legal/Minkey-Disclaimer.pdf';
}
