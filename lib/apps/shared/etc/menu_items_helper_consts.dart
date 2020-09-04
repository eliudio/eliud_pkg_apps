import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:flutter/material.dart';

menuItem(documentID, pageID, text, IconData iconData) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(codePoint: iconData.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

menuItemSignOut(documentID) => MenuItemModel(
    documentID: documentID,
    text: "Sign out",
    description: "Sign out",
    icon: IconModel(
        codePoint: Icons.power_settings_new.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: InternalAction(internalActionEnum: InternalActionEnum.Logout));

menuItemFlushCache(documentID) => MenuItemModel(
    documentID: documentID,
    text: "Flush cache",
    description: "Flush cache",
    icon: IconModel(
        codePoint: Icons.power_settings_new.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: InternalAction(internalActionEnum: InternalActionEnum.Flush));

menuItemManageAccount(documentID, pageID) => MenuItemModel(
    documentID: documentID,
    text: 'Manage your account',
    description: 'Manage your account',
    icon: IconModel(
        codePoint: Icons.account_box.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

menuItemHome(documentID, pageID) => MenuItemModel(
    documentID: documentID,
    text: "Home",
    description: "Home",
    icon: IconModel(
        codePoint: Icons.home.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

menuItemAbout(documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(codePoint: Icons.info.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

menuItemWelcome(documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(codePoint: Icons.emoji_people.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

menuItemShop(documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(codePoint: Icons.shop.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

menuItemShoppingBag(documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(codePoint: Icons.shopping_basket.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

menuItemShoppingCart(documentID, pageID, text) => MenuItemModel(
    documentID: documentID,
    text: text,
    description: text,
    icon: IconModel(codePoint: Icons.shopping_cart.codePoint, fontFamily: Icons.settings.fontFamily),
    action: GotoPage(pageID: pageID));

