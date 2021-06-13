import 'package:eliud_core/default_style/eliud_style.dart';
import 'package:eliud_core/default_style/instances/eliud_incidamus_style.dart';
import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_home_page_references_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/who/who.dart';
import 'package:eliud_pkg_apps/apps/shared/about/founders/founders.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:flutter/material.dart';

import '../app_base.dart';
import 'admin/admin.dart';
import 'hello_world/hello_world.dart';
import 'member/eliud_member_dashboard.dart';

/* This code cleans the database and generates a hello-eliud app, which includes the admin pages
 * Extend this code to support new components
 */
class EliudApp extends InstallApp {
  static String ELIUD_APP_ID = "ELIUD_APP";

  EliudApp()
      : super(
            appId: ELIUD_APP_ID,);

  @override
  MenuDefModel profileDrawerMenuDef() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Other apps",
        description: "Other apps",
        action:
            InternalAction(appId, internalActionEnum: InternalActionEnum.OtherApps)));
    menuItems.add(menuItemSignOut(appId, "2"));
    menuItems.add(menuItemFlushCache(appId, "3"));
    menuItems.add(menuItemManageAccount(appId, "4", MemberDashboard.IDENTIFIER));
    MenuDefModel menu = MenuDefModel(
        documentID: "drawer_profile_menu",
        appId: ELIUD_APP_ID,
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
    menuItems.add(menuItemHome(appId, "1", "welcome"));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "Hello World",
        description: "Hello World",
        icon: IconModel(codePoint: Icons.flight_takeoff.codePoint, fontFamily: "MaterialIcons"),
        action: GotoPage(appId, pageID: "hello_world")));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "Advanced",
        description: "Advanced",
        icon: IconModel(codePoint: Icons.tour.codePoint, fontFamily: "MaterialIcons"),
        action: GotoPage(appId, pageID: "advanced")));
    menuItems.add(menuItemAbout(appId, "4", Founders.IDENTIFIER, Founders.IDENTIFIER));
    MenuDefModel menu = MenuDefModel(
        documentID: "main",
        appId: ELIUD_APP_ID,
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
        appId: ELIUD_APP_ID,
        name: "Menu Definition 1",
        menuItems: menuItems);
  }
*/

  Future<AppModel> setupApplication(
      AppHomePageReferencesModel homePages,
      String? ownerID,
      MemberMediumModel? logo) async {
    AppModel application = AppModel(
      documentID: ELIUD_APP_ID,
      title: "Eliud!",
      description: "Eliud",
      logo: logo,
      email: "eliud.io.info@gmail.com",
      homePages: homePages,
      styleFamily: EliudStyle.eliudFamilyName,
      styleName: EliudIncidamusStyle.styleName,
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
    await Who(
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    await EliudMemberDashboard(
        installApp: this,
        backgroundColor: EliudColors.gray)
        .run();
    await HelloWorld(
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    var homePageSubscribedMember = await Welcome(
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    await createPolicyPages(appPolicyModel!, drawer, endDrawer,  adminMenu);
    AppHomePageReferencesModel homePages = AppHomePageReferencesModel(
        homePageSubscribedMemberId: homePageSubscribedMember.documentID
    );
    return homePages;
  }

  Future<void> run(String ownerID) async {
    return await runBase(
      ownerID: ownerID,
          );
  }

  @override
  Future<AppBarModel> appBar(
      String? identifier, MenuDefModel? menu, String? title) async {
    return await setupAppBar(
        identifier,
        menu,
        title,
        EliudColors.white,
        null,
        EliudColors.white,
        EliudColors.white,
        EliudColors.red,
        EliudColors.gray);
  }

  @override
  // no extra items
  List<MenuItemModel>? extraMenuItems() => null;

  @override
  String logoAssetLocation() => 'packages/eliud_pkg_apps/assets/eliud_app/logos/logo.jpg';

  @override
  String logoHeadAssetLocation() => 'packages/eliud_pkg_apps/assets/eliud_app/logos/logo_head.jpg';

  // Policies
  @override
  String privacyPolicyAssetLocation() => 'packages/eliud_pkg_apps/assets/eliud_app/legal/Eliud-Privacy-Policy.pdf';

  @override
  String termsOfServiceAssetLocation() => 'packages/eliud_pkg_apps/assets/eliud_app/legal/Eliud-Terms-of-Service.pdf';

  @override
  String disclaimerAssetLocation() => 'packages/eliud_pkg_apps/assets/eliud_app/legal/Eliud-Disclaimer.pdf';
}
