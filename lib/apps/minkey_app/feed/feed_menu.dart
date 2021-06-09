import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/follow/follow_dashboards.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as coreRepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:flutter/material.dart';

import 'feed.dart';

class FeedMenu {
  final String appId;

  FeedMenu(this.appId);

  static String FEED_MENU_ID = "feedMenu";

  MenuDefModel menuDef() {
    var menuItems = <MenuItemModel>[
      MenuItemModel(
          documentID: '1',
          text: 'Feed',
          description: 'Your Feed',
          icon: IconModel(
              codePoint: Icons.people.codePoint,
              fontFamily: Icons.settings.fontFamily),
          action: GotoPage(appId, pageID: Feed.IDENTIFIER)),
      MenuItemModel(
          documentID: '2',
          text: 'Profile',
          description: 'Your profile',
          icon: IconModel(
              codePoint: Icons.person.codePoint,
              fontFamily: Icons.settings.fontFamily),
          action: GotoPage(appId, pageID: Profile.IDENTIFIER)),
      menuItemFollowRequestsPage(
          appId,
          "3",
          FollowRequestDashboard.FOLLOW_REQUEST_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFollowersPage(appId, "4", FollowDashboards.FOLLOWERS_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFollowingPage(appId, "5", FollowDashboards.FOLLOWING_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFiendFriendsPage(appId, "6", InviteDashboard.INVITE_IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemAppMembersPage(appId, "7", MembershipDashboard.IDENTIFIER,
          PrivilegeLevelRequired.NoPrivilegeRequired),
    ];
    MenuDefModel menu = MenuDefModel(
        documentID: FEED_MENU_ID,
        appId: appId,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> createMenuDef() async {
    return await coreRepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)!
        .add(menuDef());
  }

  FeedMenuModel feedMenuModel(MenuDefModel menu) {
    return FeedMenuModel(
      documentID: FEED_MENU_ID,
      appId: appId,
      description: "Feed Menu",
      menu: menu,
      itemColor: EliudColors.black,
      selectedItemColor: EliudColors.red,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<FeedMenuModel> createFeedMenuModel(MenuDefModel menu) async {
    return await AbstractRepositorySingleton.singleton
        .feedMenuRepository(appId)!
        .add(feedMenuModel(menu));
  }

  Future<void> run() async {
    var menuDef = await createMenuDef();
    await createFeedMenuModel(menuDef);
  }
}
