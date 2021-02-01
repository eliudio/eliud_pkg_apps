import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/model/app_home_page_references_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/workflow/workflow_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/assignments/assignment_view_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:eliud_pkg_shop/model/admin_app.dart' as shop;
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/image_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/order_overview.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/process/cart.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/process/pay.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/welcome/welcome.dart';
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
import 'assignments/incidamus_assignments.dart';
import 'blocked/juuwle_blocked.dart';
import 'membership/incidamus_membership_dashboard.dart';
import 'notifications/incidamus_notification_dashboard.dart';

class IncidamusApp extends InstallApp {
  static String INCIDAMUS_APP_ID = 'INCIDAMUS_APP';

  IncidamusApp()
      : super(
            appId: INCIDAMUS_APP_ID,
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
    menuItems
        .add(menuItemManageAccount(appId, "my_incidamus", MemberPage.IDENTIFIER));
    menuItems.add(MenuItemModel(
        documentID: 'orders',
        text: 'Your orders',
        description: 'Your orders',
        icon: IconModel(codePoint: 0xe896, fontFamily: 'MaterialIcons'),
        action: GotoPage(IncidamusApp.INCIDAMUS_APP_ID,
            pageID: OrderOverview.identifier)));
    menuItems.add(menuItemSignOut(appId, 'sign_out'));
    var menu = MenuDefModel(
        documentID: 'drawer_profile_menu',
        appId: INCIDAMUS_APP_ID,
        name: 'Drawer Profile Menu',
        menuItems: menuItems);
    return menu;
  }

  @override
  MenuDefModel drawerMenuDef() {
    return homeMenuDef().copyWith(
        documentID: 'drawer_menu', name: 'Drawer Menu (copy of main menu)');
  }

  @override
  MenuDefModel homeMenuDef() {
    var menuItems = <MenuItemModel>[];
    menuItems.add(menuItemWelcome(appId, "1", Welcome.identifier, "Welcome"));
    menuItems.add(menuItemShoppingBag(appId, "2", Shop.identifier, "Shop"));
    menuItems.add(menuItemAbout(appId, "4", AboutBase.identifier, "About"));
    var menu = MenuDefModel(
        documentID: 'main',
        appId: INCIDAMUS_APP_ID,
        name: 'Main Menu',
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<void> setupApplication(AppHomePageReferencesModel homePages,
      String ownerID, ImageModel logo) async {
    var application = AppModel(
      documentID: INCIDAMUS_APP_ID,
      title: 'Incidamus!',
      description: 'Incidamus',
      logo: logo,
      email: 'ex.Incidamus@gmail.com',
      darkOrLight: DarkOrLight.Light,
      homePages: homePages,
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
      shop.AdminAppWiper(),
    ];
  }

  @override
  Future<PageModel> memberPage(
          MenuDefModel adminMenu, DrawerModel drawer, DrawerModel endDrawer) =>
      MemberPage(this, newAppTools, homeMenu(), pageBG(), drawer, endDrawer,
              adminMenu)
          .run();

  @override
  Future<AppHomePageReferencesModel> runTheRest(String ownerID,
      DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu) async {
    await WorkflowSetup(installApp: this).run();
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
    await ProductPage(
            shop: shop,
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    await IncidamusNotificationDashboard(
            installApp: this,
            newAppTools: newAppTools,
            backgroundColor: EliudColors.gray)
        .run();
    await IncidamusMembershipDashboard(
            installApp: this,
            newAppTools: newAppTools,
            backgroundColor: EliudColors.gray)
        .run();
    await IncidamusAssignmentViewSetup(
            installApp: this,
            newAppTools: newAppTools,
            backgroundColor: EliudColors.gray)
        .run();
    var homePageSubscribedMember = await Welcome(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    var homePageBlockedMember = await JuuwleBlocked(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    AppHomePageReferencesModel homePages = AppHomePageReferencesModel(
        homePageBlockedMemberId: homePageBlockedMember.documentID,
        homePageSubscribedMemberId: homePageSubscribedMember.documentID);
    return homePages;
  }

  @override
  Future<void> run(String ownerID) async {
    var urlLogo =
        'https://live.staticflickr.com/65535/50706686648_24b5b910ba_o_d.png';
    var urlLogoHead =
        'https://live.staticflickr.com/65535/49957341552_f8023b32d7_w_d.jpg';

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

  // an extra menu item for the shopping cart
  List<MenuItemModel> extraMenuItems() => <MenuItemModel>[
        MenuItemModel(
            documentID: '1',
            text: 'Your bag',
            description: 'Your bag',
            icon: IconModel(
                codePoint: Icons.shopping_basket.codePoint,
                fontFamily: Icons.shopping_basket.fontFamily),
            action:
                GotoPage(IncidamusApp.INCIDAMUS_APP_ID, pageID: MyCart.identifier)),
        MenuItemModel(
            documentID: '2',
            text: 'Notifications',
            description: 'Notifications',
            icon: IconModel(
                codePoint: Icons.notifications.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(IncidamusApp.INCIDAMUS_APP_ID,
                dialogID: NotificationDashboard.IDENTIFIER)),
        MenuItemModel(
            documentID: '3',
            text: 'Members',
            description: 'Members',
            icon: IconModel(
                codePoint: Icons.people.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(IncidamusApp.INCIDAMUS_APP_ID,
                dialogID: MembershipDashboard.IDENTIFIER)),
        MenuItemModel(
            documentID: '4',
            text: 'Assignments',
            description: 'Assignments',
            icon: IconModel(
                codePoint: Icons.playlist_add_check.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(IncidamusApp.INCIDAMUS_APP_ID,
                dialogID: AssignmentViewSetup.IDENTIFIER)),
      ];
}