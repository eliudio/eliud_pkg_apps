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
import 'package:eliud_pkg_apps/apps/juuwle_app/membership/juuwle_membership_dashboard.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/order_overview.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/cart.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/pay.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/workflow/workflow_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/assignments/assignment_view_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:eliud_pkg_shop/model/admin_app.dart' as shop;
import 'package:eliud_stl_mona/instances/mona_juuwle_style.dart';
import 'package:eliud_stl_mona/mona_style.dart';
import 'package:flutter/material.dart';

import '../app_base.dart';
import 'about/about.dart';
import 'admin/admin.dart';
import 'assignments/juuwle_assignments.dart';
import 'blocked/juuwle_blocked.dart';
import 'member/juuwle_member_dashboard.dart';
import 'notifications/juuwle_notification_dashboard.dart';

class JuuwleApp extends InstallApp {
  static String JUUWLE_APP_ID = 'JUUWLE_APP';

  JuuwleApp()
      : super(
            appId: JUUWLE_APP_ID,);

  @override
  MenuDefModel profileDrawerMenuDef() {
    var menuItems = <MenuItemModel>[];
    menuItems
        .add(menuItemManageAccount(appId, "my_juuwle", MemberDashboard.IDENTIFIER));
    menuItems.add(MenuItemModel(
        documentID: 'orders',
        text: 'Your orders',
        description: 'Your orders',
        icon: IconModel(codePoint: 0xe896, fontFamily: 'MaterialIcons'),
        action: GotoPage(JuuwleApp.JUUWLE_APP_ID,
            pageID: OrderOverview.identifier)));
    menuItems.add(menuItemSignOut(appId, 'sign_out'));
    var menu = MenuDefModel(
        documentID: 'drawer_profile_menu',
        appId: JUUWLE_APP_ID,
        name: 'Drawer Profile Menu',
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
    var menuItems = <MenuItemModel>[];
    menuItems.add(menuItemWelcome(appId, "1", Welcome.identifier, "Welcome"));
    menuItems.add(menuItemShoppingBag(appId, "2", Shop.identifier, "Shop"));
    menuItems.add(menuItemAbout(appId, "4", About.IDENTIFIER, "About"));
    var menu = MenuDefModel(
        documentID: 'main',
        appId: JUUWLE_APP_ID,
        name: 'Main Menu',
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<AppModel> setupApplication(AppHomePageReferencesModel homePages,
      String? ownerID, MemberMediumModel? logo) async {
    var application = AppModel(
      documentID: JUUWLE_APP_ID,
      title: 'Juuwle!',
      description: 'Juuwle',
      logo: logo,
      email: 'juuwle.com.info@gmail.com',
      styleFamily: MonaStyle.FAMILY_NAME,
      styleName: MonaJuuwleStyle.STYLE_NAME,
      homePages: homePages,
      routeBuilder: PageTransitionAnimation.FadeRoute,
      routeAnimationDuration: 800,
      ownerID: ownerID,
      appStatus: AppStatus.Live,
      policies: appPolicyModel,
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
      shop.AdminAppWiper(),
    ];
  }

  @override
  Future<AppHomePageReferencesModel> runTheRest(String? ownerID,
      DrawerModel drawer, DrawerModel endDrawer) async {
    await WorkflowSetup(installApp: this).run();
    await About(
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    var shop = await Shop(
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    await MyCart(
            background: Shop.cardBG(),
            shop: shop,
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    await MyPay(
            background: Shop.cardBG(),
            shop: shop,
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    await OrderOverview(
            background: Shop.cardBG(),
            shop: shop,
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    await MyPayConfirmation(
            background: Shop.cardBG(),
            shop: shop,
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    await ProductPage(
            shop: shop,
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    await JuuwleNotificationDashboard(
            installApp: this,
    )
        .run();
    await JuuwleMembershipDashboard(
        installApp: this,
        )
        .run();
    await JuuwleMemberDashboard(
        installApp: this,
        )
        .run();
    await JuuwleAssignmentViewSetup(
            installApp: this,
        )
        .run();
    var homePageSubscribedMember = await Welcome(
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    var homePageBlockedMember = await JuuwleBlocked(
            installApp: this,
            homeMenu: homeMenu(),
            drawer: drawer,
            endDrawer: endDrawer,
            )
        .run();
    await createPolicyPages(appPolicyModel!, drawer, endDrawer,);
    AppHomePageReferencesModel homePages = AppHomePageReferencesModel(
      homePageBlockedMember: homePageBlockedMember.documentID,
      homePageSubscribedMember: homePageSubscribedMember.documentID,
      homePagePublic: homePageSubscribedMember.documentID,
    );
    return homePages;
  }

  @override
  Future<void> run(String ownerID) async {
    return await runBase(
        ownerID: ownerID);
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
                GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: MyCart.identifier)),
        MenuItemModel(
            documentID: '2',
            text: 'Notifications',
            description: 'Notifications',
            icon: IconModel(
                codePoint: Icons.notifications.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(JuuwleApp.JUUWLE_APP_ID,
                dialogID: NotificationDashboard.IDENTIFIER)),
        MenuItemModel(
            documentID: '3',
            text: 'Members',
            description: 'Members',
            icon: IconModel(
                codePoint: Icons.people.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(JuuwleApp.JUUWLE_APP_ID,
                dialogID: MembershipDashboard.IDENTIFIER)),
        MenuItemModel(
            documentID: '4',
            text: 'Assignments',
            description: 'Assignments',
            icon: IconModel(
                codePoint: Icons.playlist_add_check.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(JuuwleApp.JUUWLE_APP_ID,
                dialogID: AssignmentViewSetup.IDENTIFIER)),
      ];

  @override
  String logoAssetLocation() => 'packages/eliud_pkg_apps/assets/juuwle_app/logos/logo.png';

  @override
  String logoHeadAssetLocation() => 'packages/eliud_pkg_apps/assets/juuwle_app/logos/logo_head.jpg';

  // Policies
  @override
  String privacyPolicyAssetLocation() => 'packages/eliud_pkg_apps/assets/juuwle_app/legal/Juuwle-Privacy-Policy.pdf';

  @override
  String termsOfServiceAssetLocation() => 'packages/eliud_pkg_apps/assets/juuwle_app/legal/Juuwle-Terms-of-Service.pdf';

  @override
  String disclaimerAssetLocation() => 'packages/eliud_pkg_apps/assets/juuwle_app/legal/Juuwle-Disclaimer.pdf';
}
