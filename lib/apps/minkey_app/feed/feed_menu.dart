/*
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as coreRepo;
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/follow/follow_dashboards.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:flutter/material.dart';

import '../minkey_app.dart';
import 'feed.dart';

class FeedMenu {
  FeedMenu();

  static String FEED_MENU_ID_CURRENT_MEMBER = "feedMenuCurrentMember";
  static String FEED_MENU_ID_OTHER_MEMBER = "feedMenuOtherMember";

  MenuItemModel feedMenuItem() => MenuItemModel(
        documentID: '1',
        text: 'Feed',
        description: 'Your Feed',
        icon: IconModel(
            codePoint: Icons.people.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(MinkeyApp.app, pageID: Feed.IDENTIFIER));

  MenuItemModel profileMenuItem() => MenuItemModel(
        documentID: '2',
        text: 'Profile',
        description: 'Your profile',
        icon: IconModel(
            codePoint: Icons.person.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(MinkeyApp.app, pageID: Profile.IDENTIFIER));

  MenuDefModel menuDefCurrentMember() {
    var menuItems = <MenuItemModel>[
      feedMenuItem(),
      profileMenuItem(),
      menuItemFollowRequestsPage(
          MinkeyApp.app,
          "3",
          FollowRequestDashboard.FOLLOW_REQUEST_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFollowersPage(MinkeyApp.app, "4", FollowDashboards.FOLLOWERS_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFollowingPage(MinkeyApp.app, "5", FollowDashboards.FOLLOWING_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFiendFriendsPage(MinkeyApp.app, "6", InviteDashboard.INVITE_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemAppMembersPage(MinkeyApp.app, "7", MembershipDashboard.IDENTIFIER),
    ];
    MenuDefModel menu = MenuDefModel(
        documentID: FEED_MENU_ID_CURRENT_MEMBER,
        appId: MinkeyApp.app.documentID,
        name: "Current Member Feed Menu",
        menuItems: menuItems);
    return menu;
  }

  MenuDefModel menuDefOtherMember() {
    var menuItems = <MenuItemModel>[
    feedMenuItem(),
    profileMenuItem(),
    ];
    MenuDefModel menu = MenuDefModel(
        documentID: FEED_MENU_ID_OTHER_MEMBER,
        appId: MinkeyApp.app.documentID,
        name: "Other Member Feed Menu",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> createMenuDefCurrentMember() async {
    return await coreRepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(MinkeyApp.app.documentID)!
        .add(menuDefCurrentMember());
  }

  Future<MenuDefModel> createMenuDefOtherMember() async {
    return await coreRepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(MinkeyApp.app.documentID)!
        .add(menuDefOtherMember());
  }

  static String FEED_MENU_ID = "feedMenu";
  FeedMenuModel feedMenuModel(FeedModel feed, MenuDefModel menuCurrentMember, MenuDefModel menuOtherMember, ) {
    return FeedMenuModel(
      documentID: FEED_MENU_ID,
      appId: MinkeyApp.app.documentID,
      description: "Feed Menu",
      feed: feed,
      menuCurrentMember: menuCurrentMember,
      menuOtherMember: menuOtherMember,
      itemColor: EliudColors.black,
      selectedItemColor: EliudColors.red,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<FeedMenuModel> createFeedMenuModel(FeedModel feed, MenuDefModel menuCurrentMember, MenuDefModel menuOtherMember,) async {
    return await AbstractRepositorySingleton.singleton
        .feedMenuRepository(MinkeyApp.app.documentID)!
        .add(feedMenuModel(feed, menuCurrentMember, menuOtherMember));
  }

  Future<void> run(FeedModel feed, ) async {
    var menuDefCurrentMember = await createMenuDefCurrentMember();
    var menuDefOtherMember = await createMenuDefOtherMember();
    await createFeedMenuModel(feed, menuDefCurrentMember, menuDefOtherMember);
  }
}
*/
