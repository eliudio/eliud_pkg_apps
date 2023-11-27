import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/apis/action_api/actions/internal_action.dart';
import 'package:eliud_core_main/model/app_home_page_references_model.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/icon_model.dart';
import 'package:eliud_core_main/model/menu_def_model.dart';
import 'package:eliud_core_main/model/menu_item_model.dart';
import 'package:eliud_core_main/model/public_medium_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_drawer.dart';
import 'package:eliud_core_main/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/who/who.dart';
import 'package:eliud_pkg_apps/apps/shared/about/founders/founders.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';
import 'package:eliud_pkg_create/tools/defaults.dart' as defaults;
import 'package:eliud_stl_mona/mona_style_family.dart';
import 'package:flutter/material.dart';

import '../install_app.dart';
import 'hello_world/hello_world.dart';
import 'member/eliud_member_dashboard.dart';

/* This code cleans the database and generates a hello-eliud app, which includes the admin pages
 * Extend this code to support new components
 */
class EliudApp extends InstallApp {
  static String eliudAppId = "ELIUD_APP";
  static AppModel app = AppModel(documentID: eliudAppId, ownerID: '??');

  EliudApp() : super(app);

  @override
  MenuDefModel profileDrawerMenuDef() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Other apps",
        description: "Other apps",
        action: InternalAction(EliudApp.app,
            internalActionEnum: InternalActionEnum.otherApps)));
    menuItems.add(menuItemSignOut(app, "2"));
    menuItems.add(menuItemManageAccount(app, "4", MemberDashboard.identifier));
    MenuDefModel menu = MenuDefModel(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.right),
        appId: eliudAppId,
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
    menuItems.add(menuItemHome(app, "1", "welcome"));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "Hello World",
        description: "Hello World",
        icon: IconModel(
            codePoint: Icons.flight_takeoff.codePoint,
            fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "hello_world")));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "Advanced",
        description: "Advanced",
        icon: IconModel(
            codePoint: Icons.tour.codePoint, fontFamily: "MaterialIcons"),
        action: GotoPage(EliudApp.app, pageID: "advanced")));
    menuItems.add(
        menuItemAbout(app, "4", Founders.identifier2, Founders.identifier2));
    MenuDefModel menu = MenuDefModel(
        documentID: defaults.homeMenuID(theApp.documentID),
        appId: eliudAppId,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

/*
  MenuDefModel iconMenuDef(MenuDefModel _adminMenu) {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "Admin",
        description: "Admin Stuff",
        icon: IconModel(codePoint: 0xe5d4, fontFamily: "MaterialIcons"),
        action: PopupMenu(menuDef: _adminMenu)));
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Document 1",
        description: "Document 1",
        icon: IconModel(codePoint: 0xe879, fontFamily: "MaterialIcons"),
        action: InternalAction(internalActionEnum: InternalActionEnum.Login)));
    return MenuDefModel(
        documentID: "ICON_MENU_1",
        appId: eliudAppId,
        name: "Menu Definition 1",
        menuItems: menuItems);
  }
*/

  @override
  Future<AppModel> setupApplication(AppHomePageReferencesModel homePages,
      String ownerID, PublicMediumModel? logo) async {
    AppModel application = AppModel(
      documentID: eliudAppId,
      title: "Eliud!",
      description: "Eliud",
      logo: logo,
      email: "eliud.io.info@gmail.com",
      homePages: homePages,
      styleFamily: MonaStyleFamily.monaStyleFamilyName,
      styleName: MonaStyleFamily.eliudStyleName,
      ownerID: ownerID,
      appStatus: AppStatus.live,
    );

    return await AbstractMainRepositorySingleton.singleton
        .appRepository()!
        .update(application);
  }

  @override
  Future<AppHomePageReferencesModel> runTheRest(
      String? ownerID, DrawerModel drawer, DrawerModel endDrawer) async {
    await Who(
      installApp: this,
      homeMenu: homeMenu(),
      drawer: drawer,
      endDrawer: endDrawer,
    ).run();
    await EliudMemberDashboard(installApp: this).run();
    await HelloWorld(
      installApp: this,
      homeMenu: homeMenu(),
      drawer: drawer,
      endDrawer: endDrawer,
    ).run();
    var homePageSubscribedMember = await Welcome(
      installApp: this,
      homeMenu: homeMenu(),
      drawer: drawer,
      endDrawer: endDrawer,
    ).run();
    AppHomePageReferencesModel homePages = AppHomePageReferencesModel(
      homePageSubscribedMember: homePageSubscribedMember.documentID,
      homePagePublic: homePageSubscribedMember.documentID,
    );
    return homePages;
  }

  @override
  Future<void> run(String ownerID) async {
    return await runBase(
      ownerID: ownerID,
    );
  }

  @override
  // no extra items
  List<MenuItemModel>? extraMenuItems() => null;

  @override
  String logoAssetLocation() =>
      'packages/eliud_pkg_apps/assets/eliud_app/logos/logo.jpg';

  @override
  String logoHeadAssetLocation() =>
      'packages/eliud_pkg_apps/assets/eliud_app/logos/logo_head.jpg';

  // Policies
  @override
  String privacyPolicyAssetLocation() =>
      'packages/eliud_pkg_apps/assets/eliud_app/legal/Eliud-Privacy-Policy.pdf';

  @override
  String termsOfServiceAssetLocation() =>
      'packages/eliud_pkg_apps/assets/eliud_app/legal/Eliud-Terms-of-Service.pdf';

  @override
  String disclaimerAssetLocation() =>
      'packages/eliud_pkg_apps/assets/eliud_app/legal/Eliud-Disclaimer.pdf';
}
