import 'package:eliud_core/core_package.dart';
import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/apis/action_api/actions/internal_action.dart';
import 'package:eliud_core_main/apis/action_api/actions/open_dialog.dart';
import 'package:eliud_core_main/model/display_conditions_model.dart';
import 'package:eliud_core_main/model/icon_model.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/menu_item_model.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:flutter/material.dart';

menuItem(AppModel app, documentID, pageID, text, IconData iconData) =>
    MenuItemModel(
        documentID: documentID,
        text: text,
        description: text,
        icon: IconModel(
            codePoint: iconData.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app, pageID: pageID));

menuItemSignOut(AppModel app, documentID) => MenuItemModel(
    documentID: documentID,
    text: "Sign out",
    description: "Sign out",
    icon: IconModel(
        codePoint: Icons.power_settings_new.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: InternalAction(app, internalActionEnum: InternalActionEnum.logout));

menuItemManageAccount(AppModel app, documentID, dialogID) => MenuItemModel(
    documentID: documentID,
    text: 'Manage your account',
    description: 'Manage your account',
    icon: IconModel(
        codePoint: Icons.account_box.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: OpenDialog(app,
        dialogID: dialogID,
        conditions: DisplayConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
            packageCondition: CorePackage.mustBeLoggedIn)));

menuItemHome(AppModel app, documentID, pageID) => MenuItemModel(
    documentID: documentID,
    text: "Home",
    description: "Home",
    icon: IconModel(
        codePoint: Icons.home.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app, pageID: pageID));

menuItemAbout(AppModel app, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.info.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app, pageID: pageID));

menuItemFeed(AppModel app, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.group.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app, pageID: pageID));

menuItemWelcome(AppModel app, documentID, pageID, text,
        {PrivilegeLevelRequired? privilegeLevelRequired}) =>
    MenuItemModel(
        documentID: documentID,
        text: text,
        description: text,
        icon: IconModel(
            codePoint: Icons.emoji_people.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(
          app,
          pageID: pageID,
          conditions: privilegeLevelRequired == null
              ? null
              : DisplayConditionsModel(
                  privilegeLevelRequired: privilegeLevelRequired,
                  conditionOverride: ConditionOverride
                      .exactPrivilege // make sure the member only sees exactly the page addressed to him
                  ),
        ));

menuItemShop(AppModel app, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.shop.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app, pageID: pageID));

menuItemShoppingBag(AppModel app, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.shopping_basket.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app, pageID: pageID));

menuItemShoppingCart(AppModel app, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.shopping_cart.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app, pageID: pageID));

menuItemFollowRequests(AppModel app, documentID, dialogID) => MenuItemModel(
    documentID: documentID,
    text: 'Follow requests',
    description: 'Follow requests',
    icon: IconModel(
        codePoint: Icons.favorite_border.codePoint,
        fontFamily: Icons.notifications.fontFamily),
    action: OpenDialog(
      app,
      dialogID: dialogID,
    ));

menuItemFollowRequestsPage(
        AppModel app, documentID, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: documentID,
        text: 'Follow Requests',
        description: 'Follow Requests',
        icon: IconModel(
            codePoint: Icons.person.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: GotoPage(app,
            pageID: pageID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition:
                    FollowPackage.conditionMemberHasOpenRequests)));

menuItemFollowers(AppModel app, documentID, dialogID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: documentID,
        text: 'Followers',
        description: 'Followers',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: OpenDialog(app,
            dialogID: dialogID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

menuItemFollowersPage(
        AppModel app, documentID, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: documentID,
        text: 'Followers',
        description: 'Followers',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID: pageID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

menuItemFollowing(AppModel app, documentID, dialogID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: documentID,
        text: 'Following',
        description: 'Following',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: OpenDialog(app,
            dialogID: dialogID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

menuItemFollowingPage(
        AppModel app, documentID, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: documentID,
        text: 'Following',
        description: 'Following',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID: pageID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

menuItemAppMembers(
        AppModel app, documentID, dialogID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: '5',
        text: 'App Members',
        description: 'Members of the app',
        icon: IconModel(
            codePoint: Icons.people.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: OpenDialog(
          app,
          conditions: DisplayConditionsModel(
              privilegeLevelRequired: privilegeLevelRequired,
              packageCondition: CorePackage.mustBeLoggedIn),
          dialogID: dialogID,
        ));

menuItemAppMembersPage(AppModel app, documentID, pageID) => MenuItemModel(
    documentID: '5',
    text: 'App Members',
    description: 'Members of the app',
    icon: IconModel(
        codePoint: Icons.people.codePoint,
        fontFamily: Icons.notifications.fontFamily),
    action: MembershipDashboard.action(app));

menuItemFiendFriends(
        AppModel app, documentID, dialogID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: documentID,
        text: 'Find friends',
        description: 'Fiend friends',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: OpenDialog(app,
            dialogID: dialogID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

menuItemFiendFriendsPage(
        AppModel app, documentID, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: documentID,
        text: 'Find friends',
        description: 'Fiend friends',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID: pageID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));
