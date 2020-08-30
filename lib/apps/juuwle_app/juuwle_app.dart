import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/image_model.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/order_overview.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/cart.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/pay.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
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

class JuuwleApp extends InstallApp {
  static String JUUWLE_APP_ID = 'JUUWLE_APP';

  JuuwleApp()
      : super(
            appId: JUUWLE_APP_ID,
            appColor1: EliudColors.bordeauxRed,
            appColor2: EliudColors.ochre,
            appColor3: EliudColors.ochreTransparent,
            appColor4: EliudColors.white,
            dividerColor: EliudColors.gray,
            homeMenuIconColor: EliudColors.black,
            homeMenuPopupBGColor: EliudColors.white,
            headerColor1To3: EliudColors.lightBlueTransparent,
            headerColor4To5: EliudColors.black,
            defaultColor: EliudColors.black,
            highlightColor: EliudColors.ochre,
            linkColor: EliudColors.ochre);

  @override
  MenuDefModel profileDrawerMenuDef() {
    var menuItems = <MenuItemModel>[];
    menuItems.add(MenuItemModel(
        documentID: 'my_juuwle',
        text: 'Manage your account',
        description: 'Manage your account',
        icon: IconModel(codePoint: 0xe8b9, fontFamily: 'MaterialIcons'),
        action: GotoPage(pageID: MemberPage.IDENTIFIER)));
    menuItems.add(MenuItemModel(
        documentID: 'orders',
        text: 'Your orders',
        description: 'Your orders',
        icon: IconModel(codePoint: 0xe896, fontFamily: 'MaterialIcons'),
        action: GotoPage(pageID: OrderOverview.identifier)));
    menuItems.add(MenuItemModel(
        documentID: 'sign_out',
        text: 'Sign out',
        description: 'Sign out',
        icon: IconModel(codePoint: 0xe879, fontFamily: 'MaterialIcons'),
        action: InternalAction(internalActionEnum: InternalActionEnum.Logout)));
    var menu = MenuDefModel(
        documentID: 'drawer_profile_menu',
        appId: JUUWLE_APP_ID,
        name: 'Drawer Profile Menu',
        menuItems: menuItems);
    return menu;
  }

  @override
  MenuDefModel drawerMenuDef() {
    return homeMenuDef().copyWith(documentID: 'drawer_menu', name: 'Drawer Menu (copy of main menu)');
  }

  @override
  MenuDefModel homeMenuDef() {
    var menuItems = <MenuItemModel>[];
    menuItems.add(MenuItemModel(
        documentID: '1',
        text: 'Welcome',
        description: 'Welcome',
        icon: IconModel(codePoint: 0xe88a, fontFamily: 'MaterialIcons'),
        action: GotoPage(pageID: Welcome.identifier)));
    menuItems.add(MenuItemModel(
        documentID: '2',
        text: 'Shop',
        description: 'Shop',
        icon: IconModel(codePoint: 0xe9dd, fontFamily: 'MaterialIcons'),
        action: GotoPage(pageID: Shop.identifier)));
    menuItems.add(MenuItemModel(
        documentID: '4',
        text: 'About',
        description: 'About',
        icon: IconModel(codePoint: 0xe7fb, fontFamily: 'MaterialIcons'),
        action: GotoPage(pageID: AboutBase.identifier)));
    var menu = MenuDefModel(
        documentID: 'main',
        appId: JUUWLE_APP_ID,
        name: 'Main Menu',
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<void> setupApplication(
      PageModel homePage, String ownerID, ImageModel logo) {
    var application = AppModel(
      documentID: JUUWLE_APP_ID,
      title: 'Juuwle!',
      description: 'Juuwle',
      logo: logo,
      email: 'juuwle.com.info@gmail.com',
      darkOrLight: DarkOrLight.Light,
      entryPage: homePage,
      formBackground: pageBG(),
      formSubmitButtonColor: EliudColors.red,
      formSubmitButtonTextColor: EliudColors.white,
      formGroupTitleColor: EliudColors.red,
      formFieldTextColor: EliudColors.black,
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
      h1: fontTools.getFont(
          FontTools.key(FontTools.dancingScriptLabel, FontTools.h1Label)),
      h2: fontTools.getFont(
          FontTools.key(FontTools.dancingScriptLabel, FontTools.h2Label)),
      h3: fontTools.getFont(
          FontTools.key(FontTools.dancingScriptLabel, FontTools.h3Label)),
      h4: fontTools.getFont(
          FontTools.key(FontTools.dancingScriptLabel, FontTools.h4Label)),
      h5: fontTools.getFont(
          FontTools.key(FontTools.dancingScriptLabel, FontTools.h5Label)),
      fontHighlight1: fontTools.getFont(FontTools.key(
          FontTools.dancingScriptLabel, FontTools.highlightLabel1)),
      fontHighlight2: fontTools.getFont(FontTools.key(
          FontTools.dancingScriptLabel, FontTools.highlightLabel2)),
      fontLink: fontTools.getFont(
          FontTools.key(FontTools.dancingScriptLabel, FontTools.linkLabel)),
      fontText: fontTools.getFont(
          FontTools.key(FontTools.dancingScriptLabel, FontTools.normalLabel)),
    );
    return AbstractMainRepositorySingleton.singleton
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
  Future<PageModel> memberPage(
          MenuDefModel adminMenu, DrawerModel drawer, DrawerModel endDrawer) =>
      MemberPage(this, newAppTools, homeMenu(), pageBG(), drawer, endDrawer,
              adminMenu)
          .run();

  @override
  Future<PageModel> runTheRest(
      DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu) async {
    await About(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    var shop = await Shop(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    await MyCart(
        background: Shop.cardBG(appId),
        shop: shop,
        installApp: this,
        newAppTools: newAppTools,
        homeMenu: homeMenu(),
        pageBG: pageBG(),
        drawer: drawer,
        endDrawer: endDrawer,
        adminMenu: adminMenu)
        .run();
    await MyPay(
        background: Shop.cardBG(appId),
        shop: shop,
        installApp: this,
        newAppTools: newAppTools,
        homeMenu: homeMenu(),
        pageBG: pageBG(),
        drawer: drawer,
        endDrawer: endDrawer,
        adminMenu: adminMenu)
        .run();
    await OrderOverview(
        background: Shop.cardBG(appId),
        shop: shop,
        installApp: this,
        newAppTools: newAppTools,
        homeMenu: homeMenu(),
        pageBG: pageBG(),
        drawer: drawer,
        endDrawer: endDrawer,
        adminMenu: adminMenu)
        .run();
    await MyPayConfirmation(
        background: Shop.cardBG(appId),
        shop: shop,
        installApp: this,
        newAppTools: newAppTools,
        homeMenu: homeMenu(),
        pageBG: pageBG(),
        drawer: drawer,
        endDrawer: endDrawer,
        adminMenu: adminMenu)
        .run();
    return await Welcome(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
  }

  @override
  Future<void> run(String ownerID) async {
    var urlLogo =
        'https://live.staticflickr.com/65535/49956557678_154a1c9c18_o_d.png';
    var urlLogoHead =
        'https://live.staticflickr.com/65535/49957341552_351cd8123c_o_d.png';

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
        EliudColors.white,
        EliudColors.lightRed);
  }

  MenuDefModel _appBarMenu(String title, MenuDefModel adminMenu) {
    var menuItems = <MenuItemModel>[];
    menuItems.add(MenuItemModel(
        documentID: '1',
        text: 'Your bag',
        description: 'Your bag',
        icon: IconModel(codePoint: 0xe8cb, fontFamily: 'MaterialIcons'),
        action: GotoPage(pageID: MyCart.identifier)));
    menuItems.add(MenuItemModel(
        documentID: '2',
        text: 'Sign in',
        description: 'Sign in',
        action: InternalAction(internalActionEnum: InternalActionEnum.Login)));
    menuItems.add(MenuItemModel(
        documentID: '3',
        text: 'Admin',
        description: 'Admin',
        icon: IconModel(codePoint: 0xe8b8, fontFamily: 'MaterialIcons'),
        action: PopupMenu(menuDef: adminMenu)));

    var menu = MenuDefModel(
        documentID: appBarMenuIdentifier,
        appId: appId,
        name: title,
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<MenuDefModel> appBarMenu(String title, MenuDefModel adminMenu) {
    return AbstractRepositorySingleton.singleton.menuDefRepository().add(_appBarMenu(title, adminMenu));
  }
}
