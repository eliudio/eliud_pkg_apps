import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:flutter/material.dart';

menuItem(appID, documentID, pageID, text, IconData iconData) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: iconData.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemSignOut(appID, documentID) => MenuItemModel(
    documentID: documentID,
    text: "Sign out",
    description: "Sign out",
    icon: IconModel(
        codePoint: Icons.power_settings_new.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action:
        InternalAction(appID, internalActionEnum: InternalActionEnum.Logout));

menuItemFlushCache(appID, documentID) => MenuItemModel(
    documentID: documentID,
    text: "Flush cache",
    description: "Flush cache",
    icon: IconModel(
        codePoint: Icons.power_settings_new.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action:
        InternalAction(appID, internalActionEnum: InternalActionEnum.Flush));

menuItemManageAccount(appID, documentID, dialogID) => MenuItemModel(
    documentID: documentID,
    text: 'Manage your account',
    description: 'Manage your account',
    icon: IconModel(
        codePoint: Icons.account_box.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: OpenDialog(appID,
        dialogID: dialogID,
        conditions: ConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemHome(appID, documentID, pageID) => MenuItemModel(
    documentID: documentID,
    text: "Home",
    description: "Home",
    icon: IconModel(
        codePoint: Icons.home.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemAbout(appID, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.info.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemFeed(appID, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.group.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemWelcome(appID, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.emoji_people.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemShop(appID, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.shop.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemShoppingBag(appID, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.shopping_basket.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemShoppingCart(appID, documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.shopping_cart.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(appID, pageID: pageID));

menuItemFollowRequests(appID, documentID, dialogID) =>
    MenuItemModel(
    documentID: documentID,
    text: 'Follow requests',
    description: 'Follow requests',
    icon: IconModel(
        codePoint: Icons.favorite_border.codePoint,
        fontFamily: Icons.notifications.fontFamily),
    action: OpenDialog(
            appID,
            dialogID: dialogID,
    ));

menuItemFollowers(appID, documentID, dialogID, privilegeLevelRequired) => MenuItemModel(
    documentID: documentID,
    text: 'Followers',
    description: 'Followers',
    icon: IconModel(
        codePoint: Icons.favorite_sharp.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: OpenDialog(appID,
        dialogID: dialogID,
        conditions: ConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemFollowing(appID, documentID, dialogID, privilegeLevelRequired) => MenuItemModel(
    documentID: documentID,
    text: 'Following',
    description: 'Following',
    icon: IconModel(
        codePoint: Icons.favorite_sharp.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: OpenDialog(appID,
        dialogID: dialogID,
        conditions: ConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemAppMembers(appID, documentID, dialogID, privilegeLevelRequired) => MenuItemModel(
    documentID: '5',
    text: 'App Members',
    description: 'Members of the app',
    icon: IconModel(
        codePoint: Icons.people.codePoint,
        fontFamily: Icons.notifications.fontFamily),
    action: OpenDialog(
            appID,
            conditions: ConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.MUST_BE_LOGGED_ON),
            dialogID: dialogID,
    ));

menuItemFiendFriends(appID, documentID, dialogID, privilegeLevelRequired) => MenuItemModel(
    documentID: documentID,
    text: 'Find friends',
    description: 'Fiend friends',
    icon: IconModel(
        codePoint: Icons.favorite_sharp.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: OpenDialog(appID,
        dialogID: dialogID,
        conditions: ConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

