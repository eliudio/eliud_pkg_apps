import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/apis/action_api/actions/internal_action.dart';
import 'package:eliud_core_main/apis/action_api/actions/popup_menu.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart';
import 'package:eliud_core_main/model/icon_model.dart';
import 'package:eliud_core_main/model/menu_def_model.dart';
import 'package:eliud_core_main/model/menu_item_model.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/hello_world/pages.dart';
import 'package:flutter/material.dart';

import '../eliud_app.dart';

class HelloWorldMenu {
  MenuDefModel _prepareHelloWorldMenu() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createGoogleAccount,
        text: "1.1 Create Google Account",
        description: "1.1 Create Google Account",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createGoogleAccount)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createFirebaseProject,
        text: "1.2 Create Firebase Project",
        description: "1.2 Create Firebase Project",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createFirebaseProject)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createDatabase,
        text: "1.3 Create Database",
        description: "1.3 Create Database",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action:
            GotoPage(EliudApp.app, pageID: HelloWorldPages.createDatabase)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createStorage,
        text: "1.4 Create Storage",
        description: "1.4 Create Storage",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app, pageID: HelloWorldPages.createStorage)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createAuthentication,
        text: "1.5 Setup Authentication",
        description: "1.5 Setup Authentication",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createAuthentication)));
    return MenuDefModel(
        documentID: "prepare_hello_world",
        appId: EliudApp.eliudAppId,
        name: "1. Prepare",
        menuItems: menuItems);
  }

  MenuDefModel _createAndroidAppMenu() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createFlutterWebProject,
        text: "2.1.1 Create Android Studio Flutter Project",
        description:
            "2.1.1 Create Android Studio Flutter Project for Android App",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createFlutterWebProject)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createWebApp,
        text: "2.1.2 Create Firebase Android App",
        description: "2.1.2 Create Firebase Android App",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app, pageID: HelloWorldPages.createWebApp)));
    return MenuDefModel(
        documentID: "create_android_app",
        appId: EliudApp.eliudAppId,
        name: "2.1 Create Android App",
        menuItems: menuItems);
  }

  MenuDefModel _createIPhoneAppMenu() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createFlutterProject,
        text: "2.2.1 Create Android Studio Flutter Project",
        description: "2.2.1 Create Android Studio Flutter Project",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createFlutterProject)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createAndroidApp,
        text: "2.2.2 Create Firebase iPhone App",
        description: "2.2.2 Create Firebase iPhone App",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action:
            GotoPage(EliudApp.app, pageID: HelloWorldPages.createAndroidApp)));
    return MenuDefModel(
        documentID: "create_iphone_app",
        appId: EliudApp.eliudAppId,
        name: "2.2 Create iPhone App",
        menuItems: menuItems);
  }

  MenuDefModel _createWebAppMenu() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createFlutterProject,
        text: "2.3.1 Create Firebase Web App",
        description: "2.3.1 Create Firebase Web App",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app, pageID: HelloWorldPages.createWebApp)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createAndroidApp,
        text: "2.3.2 Create Visual Studio Flutter Project for Web App",
        description: "2.3.2 Create Visual Studio Flutter Project for Web App",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createFlutterWebProject)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.deployWebApp,
        text: "2.3.3 Deploy your Web App",
        description: "2.3.3 Deploy your Web App",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app, pageID: HelloWorldPages.deployWebApp)));
    return MenuDefModel(
        documentID: "createWebApp",
        appId: EliudApp.eliudAppId,
        name: "2.3 Create Web App",
        menuItems: menuItems);
  }

  MenuDefModel _setupHelloWorldMenu() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createAndroidApp,
        text: "3.1 Add a page",
        description: "3.1 Add a page",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action:
            GotoPage(EliudApp.app, pageID: HelloWorldPages.createAndroidApp)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createFlutterProject,
        text: "3.2 Setup a drawer",
        description: "3.2 Setup a drawer",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createFlutterProject)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createFlutterProject,
        text: "3.3 Add a home page",
        description: "3.3 Add a home page",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createFlutterProject)));
    menuItems.add(MenuItemModel(
        documentID: HelloWorldPages.createFlutterProject,
        text: "3.4 Add an app bar",
        description: "3.4 Add an app bar",
        icon: IconModel(
            codePoint: Icons.arrow_right.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(EliudApp.app,
            pageID: HelloWorldPages.createFlutterProject)));
    return MenuDefModel(
        documentID: "setup_hello_world",
        appId: EliudApp.eliudAppId,
        name: "3. Configure your App",
        menuItems: menuItems);
  }

  MenuDefModel _createAppMenu() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "2.1 Create Android App",
        description: "2.1 Create Android App",
        action: PopupMenu(EliudApp.app, menuDef: _createAndroidAppMenu())));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "2.2 Create iPhone App",
        description: "2.2 Create iPhone App",
        action: PopupMenu(EliudApp.app, menuDef: _createIPhoneAppMenu())));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "2.3 Create Web App",
        description: "2.3 Create Web App",
        action: PopupMenu(EliudApp.app, menuDef: _createWebAppMenu())));
    MenuDefModel menu = MenuDefModel(
        documentID: "CREATE_APP_MENU",
        appId: EliudApp.eliudAppId,
        name: "Create App Menu",
        menuItems: menuItems);
    return menu;
  }

  MenuDefModel _helloWorldMenu() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "1. Prepare",
        description: "Prepare Hello World",
        icon:
            IconModel(codePoint: 0xe3d0, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(EliudApp.app, menuDef: _prepareHelloWorldMenu())));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "2. Create App",
        description: "Create App",
        icon:
            IconModel(codePoint: 0xe3d1, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(EliudApp.app, menuDef: _createAppMenu())));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "3. Configure your app",
        description: "Configure your app",
        icon:
            IconModel(codePoint: 0xe3d2, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(EliudApp.app, menuDef: _setupHelloWorldMenu())));
    menuItems.add(MenuItemModel(
        documentID: "4",
        text: "Sign in",
        description: "Sign in",
        action: InternalAction(EliudApp.app,
            internalActionEnum: InternalActionEnum.login)));
    MenuDefModel menu = MenuDefModel(
        documentID: "hello_world_menu",
        appId: EliudApp.eliudAppId,
        name: "Hello World",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> run() async {
    await AbstractRepositorySingleton.singleton
        .menuDefRepository(EliudApp.eliudAppId)!
        .add(_prepareHelloWorldMenu());
    await AbstractRepositorySingleton.singleton
        .menuDefRepository(EliudApp.eliudAppId)!
        .add(_createAppMenu());
    await AbstractRepositorySingleton.singleton
        .menuDefRepository(EliudApp.eliudAppId)!
        .add(_createAndroidAppMenu());
    await AbstractRepositorySingleton.singleton
        .menuDefRepository(EliudApp.eliudAppId)!
        .add(_createIPhoneAppMenu());
    await AbstractRepositorySingleton.singleton
        .menuDefRepository(EliudApp.eliudAppId)!
        .add(_createWebAppMenu());
    await AbstractRepositorySingleton.singleton
        .menuDefRepository(EliudApp.eliudAppId)!
        .add(_setupHelloWorldMenu());
    return await AbstractRepositorySingleton.singleton
        .menuDefRepository(EliudApp.eliudAppId)!
        .add(_helloWorldMenu());
  }
}
