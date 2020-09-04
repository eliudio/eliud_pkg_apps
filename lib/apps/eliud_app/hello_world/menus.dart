import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/hello_world/pages.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:flutter/material.dart';

import '../eliud_app.dart';

class HelloWorldMenu {
  MenuDefModel _prepareHelloWorldMenu() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_GOOGLE_ACCOUNT, text: "1.1 Create Google Account", description: "1.1 Create Google Account", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_GOOGLE_ACCOUNT)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_FIREBASE_PROJECT, text: "1.2 Create Firebase Project", description: "1.2 Create Firebase Project", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_FIREBASE_PROJECT)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_DATABASE, text: "1.3 Create Database", description: "1.3 Create Database", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_DATABASE)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_STORAGE, text: "1.4 Create Storage", description: "1.4 Create Storage", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_STORAGE)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_AUTHENTICATION, text: "1.5 Setup Authentication", description: "1.5 Setup Authentication", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_AUTHENTICATION)));
    return MenuDefModel(
        documentID: "prepare_hello_world",
        appId: EliudApp.ELIUD_APP_ID,
        name: "1. Prepare",
        menuItems: menuItems);
  }

  MenuDefModel _createAndroidAppMenu() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_FLUTTER_WEBPROJECT, text: "2.1.1 Create Android Studio Flutter Project", description: "2.1.1 Create Android Studio Flutter Project for Android App", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_WEBPROJECT)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_WEB_APP, text: "2.1.2 Create Firebase Android App", description: "2.1.2 Create Firebase Android App", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_WEB_APP)));
    return MenuDefModel(
        documentID: "create_android_app",
        appId: EliudApp.ELIUD_APP_ID,
        name: "2.1 Create Android App",
        menuItems: menuItems);
  }

  MenuDefModel _createIPhoneAppMenu() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_FLUTTER_PROJECT, text: "2.2.1 Create Android Studio Flutter Project", description: "2.2.1 Create Android Studio Flutter Project", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_PROJECT)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_ANDROID_APP, text: "2.2.2 Create Firebase iPhone App", description: "2.2.2 Create Firebase iPhone App", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)));
    return MenuDefModel(
        documentID: "create_iphone_app",
        appId: EliudApp.ELIUD_APP_ID,
        name: "2.2 Create iPhone App",
        menuItems: menuItems);
  }

  MenuDefModel _createWebAppMenu() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_FLUTTER_PROJECT, text: "2.3.1 Create Firebase Web App", description: "2.3.1 Create Firebase Web App", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_WEB_APP)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_ANDROID_APP, text: "2.3.2 Create Visual Studio Flutter Project for Web App", description: "2.3.2 Create Visual Studio Flutter Project for Web App", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_WEBPROJECT)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.DEPLOY_WEB_APP, text: "2.3.3 Deploy your Web App", description: "2.3.3 Deploy your Web App", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.DEPLOY_WEB_APP)));
    return MenuDefModel(
        documentID: "create_web_app",
        appId: EliudApp.ELIUD_APP_ID,
        name: "2.3 Create Web App",
        menuItems: menuItems);
  }

  MenuDefModel _setupHelloWorldMenu() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_ANDROID_APP, text: "3.1 Add a page", description: "3.1 Add a page", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_ANDROID_APP)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_FLUTTER_PROJECT, text: "3.2 Setup a drawer", description: "3.2 Setup a drawer", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_PROJECT)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_FLUTTER_PROJECT, text: "3.3 Add a home page", description: "3.3 Add a home page", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_PROJECT)));
    menuItems.add(MenuItemModel(documentID: HelloWorldPages.CREATE_FLUTTER_PROJECT, text: "3.4 Add an app bar", description: "3.4 Add an app bar", icon: IconModel(codePoint: Icons.arrow_right.codePoint, fontFamily: Icons.settings.fontFamily), action: GotoPage(pageID: HelloWorldPages.CREATE_FLUTTER_PROJECT)));
    return MenuDefModel(
        documentID: "setup_hello_world",
        appId: EliudApp.ELIUD_APP_ID,
        name: "3. Configure your App",
        menuItems: menuItems);
  }

  MenuDefModel _createAppMenu() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "2.1 Create Android App",
        description: "2.1 Create Android App",
        action: PopupMenu(menuDef: _createAndroidAppMenu())));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "2.2 Create iPhone App",
        description: "2.2 Create iPhone App",
        action: PopupMenu(menuDef: _createIPhoneAppMenu())));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "2.3 Create Web App",
        description: "2.3 Create Web App",
        action: PopupMenu(menuDef: _createWebAppMenu())));
    MenuDefModel menu = MenuDefModel(
        documentID: "CREATE_APP_MENU",
        appId: EliudApp.ELIUD_APP_ID,
        name: "Create App Menu",
        menuItems: menuItems);
    return menu;
  }

  MenuDefModel _helloWorldMenu(MenuDefModel adminMenu) {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "1. Prepare",
        description: "Prepare Hello World",
        icon: IconModel(codePoint: 0xe3d0, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(menuDef: _prepareHelloWorldMenu())));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "2. Create App",
        description: "Create App",
        icon: IconModel(codePoint: 0xe3d1, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(menuDef: _createAppMenu())));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "3. Configure your app",
        description: "Configure your app",
        icon: IconModel(codePoint: 0xe3d2, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(menuDef: _setupHelloWorldMenu())));
    menuItems.add(MenuItemModel(
        documentID: "4",
        text: "Sign in",
        description: "Sign in",
        action: InternalAction(internalActionEnum: InternalActionEnum.Login)));
    menuItems.add(MenuItemModel(
        documentID: "ADMIN",
        text: "Admin",
        description: "Admin",
        icon: IconModel(codePoint: 0xe8b8, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(menuDef: adminMenu)));
    MenuDefModel menu = MenuDefModel(
        documentID: "hello_world_menu",
        appId: EliudApp.ELIUD_APP_ID,
        name: "Hello World",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> run(MenuDefModel adminMenu) {
    return AbstractRepositorySingleton.singleton.menuDefRepository().add(_prepareHelloWorldMenu())
        .then((_) => AbstractRepositorySingleton.singleton.menuDefRepository().add(_createAppMenu()))
        .then((_) => AbstractRepositorySingleton.singleton.menuDefRepository().add(_createAndroidAppMenu()))
        .then((_) => AbstractRepositorySingleton.singleton.menuDefRepository().add(_createIPhoneAppMenu()))
        .then((_) => AbstractRepositorySingleton.singleton.menuDefRepository().add(_createWebAppMenu()))
        .then((_) => AbstractRepositorySingleton.singleton.menuDefRepository().add(_setupHelloWorldMenu()))
        .then((_) => AbstractRepositorySingleton.singleton.menuDefRepository().add(_helloWorldMenu(adminMenu)));
  }
}
