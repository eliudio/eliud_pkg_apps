import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:eliud_core/model/image_model.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/store/play_store.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_page.dart';
import 'package:eliud_pkg_apps/apps/tools/font_tools.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:flutter/material.dart';

import '../app_base.dart';
import 'about/about.dart';
import 'admin/admin.dart';
import 'feed/feed.dart';

/* This code cleans the database and generates the minkey app, which includes the admin pages
 */
class MinkeyApp extends InstallApp {
  static String MINKEY_APP_ID = "MINKEY_APP";

  MinkeyApp()
      : super(
            appId: MINKEY_APP_ID,
            appColor1: EliudColors.red,
            appColor2: EliudColors.white,
            appColor3: EliudColors.lightRed,
            appColor4: EliudColors.white,
            dividerColor: EliudColors.gray,
            homeMenuIconColor: EliudColors.black,
            homeMenuPopupBGColor: EliudColors.white,
            headerColor1To3: EliudColors.white,
            headerColor4To5: EliudColors.black,
            defaultColor: EliudColors.black,
            highlightColor: EliudColors.red,
            linkColor: EliudColors.white);

  @override
  MenuDefModel profileDrawerMenuDef() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Other apps",
        description: "Other apps",
        action: InternalAction(appId,
            internalActionEnum: InternalActionEnum.OtherApps)));
    menuItems.add(menuItemSignOut(appId, "2"));
    menuItems.add(menuItemFlushCache(appId, "3"));
    menuItems.add(menuItemManageAccount(appId, "4", MemberPage.IDENTIFIER));
    MenuDefModel menu = MenuDefModel(
        documentID: "drawer_profile_menu",
        appId: MINKEY_APP_ID,
        name: "Drawer Profile Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  MenuDefModel drawerMenuDef() {
    return homeMenuDef().copyWith(
        documentID: "drawer_menu", name: "Drawer Menu (copy of main menu)");
  }

  @override
  MenuDefModel homeMenuDef() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(menuItemFeed(appId, "1", Feed.IDENTIFIER, "Feed"));
    menuItems.add(menuItem(
        appId, "2", PlayStore.IDENTIFIER, "Apps", Icons.power_settings_new));
    menuItems.add(menuItemWelcome(appId, "3", Welcome.IDENTIFIER, "Welcome"));
    menuItems.add(menuItemAbout(appId, "4", AboutBase.identifier, "About"));
    MenuDefModel menu = MenuDefModel(
        documentID: "main",
        appId: MINKEY_APP_ID,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<void> setupApplication(
      PageModel homePage, String ownerID, ImageModel logo) async {
    AppModel application = AppModel(
      documentID: MINKEY_APP_ID,
      title: "Minkey!",
      description: "Minkey",
      logo: logo,
      email: "minkey.io.info@gmail.com",
      darkOrLight: DarkOrLight.Light,
      entryPage: homePage,
      formBackground: pageBG(),
      formSubmitButtonColor: EliudColors.red,
      formSubmitButtonTextColor: EliudColors.white,
      formGroupTitleColor: EliudColors.red,
      formFieldTextColor: EliudColors.white,
      formFieldHeaderColor: EliudColors.red,
      formFieldFocusColor: EliudColors.red,
      formAppBarBackground: appBarBG(),
      formAppBarTextColor: EliudColors.white,
      listTextItemColor: EliudColors.white,
      listBackground: pageBG(),
      floatingButtonForegroundColor: EliudColors.white,
      floatingButtonBackgroundColor: EliudColors.red,
      dividerColor: EliudColors.red,
      routeBuilder: PageTransitionAnimation.FadeRoute,
      routeAnimationDuration: 800,
      ownerID: ownerID,
      appStatus: AppStatus.Live,
      h1: fontTools
          .getFont(FontTools.key(FontTools.latoLabel, FontTools.h1Label)),
      h2: fontTools
          .getFont(FontTools.key(FontTools.latoLabel, FontTools.h2Label)),
      h3: fontTools
          .getFont(FontTools.key(FontTools.latoLabel, FontTools.h3Label)),
      h4: fontTools
          .getFont(FontTools.key(FontTools.latoLabel, FontTools.h4Label)),
      h5: fontTools
          .getFont(FontTools.key(FontTools.latoLabel, FontTools.h5Label)),
      fontHighlight1: fontTools.getFont(
          FontTools.key(FontTools.latoLabel, FontTools.highlightLabel1)),
      fontHighlight2: fontTools.getFont(
          FontTools.key(FontTools.latoLabel, FontTools.highlightLabel2)),
      fontLink: fontTools
          .getFont(FontTools.key(FontTools.latoLabel, FontTools.linkLabel)),
      fontText: fontTools
          .getFont(FontTools.key(FontTools.latoLabel, FontTools.normalLabel)),
    );
    return await AbstractMainRepositorySingleton.singleton
        .appRepository()
        .update(application);
  }

  @override
  AdminBase adminBase(DrawerModel drawer, DrawerModel endDrawer) => Admin(
      installApp: this,
      newAppTools: newAppTools,
      homeMenu: homeMenu(),
      pageBG: pageBG(),
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
  Future<PageModel> memberPage(
          MenuDefModel adminMenu, DrawerModel drawer, DrawerModel endDrawer) =>
      MemberPage(this, newAppTools, homeMenu(), pageBG(), drawer, endDrawer,
              adminMenu)
          .run();

  @override
  Future<PageModel> runTheRest(String ownerID, DrawerModel drawer,
      DrawerModel endDrawer, MenuDefModel adminMenu) async {
    var member = await AbstractMainRepositorySingleton.singleton
        .memberRepository()
        .get(ownerID);
    await About(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    await Welcome(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    await PlayStore(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    return await Feed(
        installApp: this,
        newAppTools: newAppTools,
        homeMenu: homeMenu(),
        pageBG: pageBG(),
        drawer: drawer,
        endDrawer: endDrawer,
        adminMenu: adminMenu)
        .run(member);
  }

  Future<void> run(String ownerID) async {
    String urlLogo =
        "https://live.staticflickr.com/65535/49878112957_dbdb0c0c5a_c_d.jpg";
    String urlLogoHead =
        "https://live.staticflickr.com/65535/49891938886_216692242a_w_d.jpg";

    return await runBase(
        ownerID: ownerID, urlLogo: urlLogo, urlLogoHead: urlLogoHead);
  }

  @override
  Future<AppBarModel> appBar(
      String identifier, MenuDefModel menu, String title) async {
    return await setupAppBar(
        identifier,
        menu,
        title,
        EliudColors.black,
        appBarBG(),
        EliudColors.black,
        EliudColors.black,
        EliudColors.green,
        EliudColors.lightRed);
  }

  @override
  // no extra items
  List<MenuItemModel> extraMenuItems() => null;
}
