import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/model/app_home_page_references_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/style/frontend/has_drawer.dart';
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
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';
import 'package:eliud_pkg_create/tools/defaults.dart' as defaults;
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:eliud_pkg_shop/model/admin_app.dart' as shop;
import 'package:eliud_stl_mona/mona_style_family.dart';
import 'package:flutter/material.dart';

import '../install_app.dart';
import 'about/about.dart';
import 'admin/admin.dart';
import 'assignments/juuwle_assignments.dart';
import 'blocked/juuwle_blocked.dart';
import 'member/juuwle_member_dashboard.dart';
import 'notifications/juuwle_notification_dashboard.dart';

class JuuwleApp extends InstallApp {
  static String JUUWLE_APP_ID = 'JUUWLE_APP';
  static AppModel app = AppModel(documentID: JUUWLE_APP_ID, ownerID: '??');

  JuuwleApp()
      : super(app);

  @override
  MenuDefModel profileDrawerMenuDef() {
    var menuItems = <MenuItemModel>[];
    menuItems
        .add(menuItemManageAccount(app, "my_juuwle", MemberDashboard.IDENTIFIER));
    menuItems.add(MenuItemModel(
        documentID: 'orders',
        text: 'Your orders',
        description: 'Your orders',
        icon: IconModel(codePoint: 0xe896, fontFamily: 'MaterialIcons'),
        action: GotoPage(app,
            pageID: OrderOverview.identifier)));
    menuItems.add(menuItemSignOut(app, 'sign_out'));
    var menu = MenuDefModel(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.Right),
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
        documentID: defaults.drawerID(theApp.documentID, DrawerType.Left), name: "Drawer Menu (copy of main menu)",
        menuItems: drawerMenuItems
    );
    return drawerMenu;
  }

  @override
  MenuDefModel homeMenuDef() {
    var menuItems = <MenuItemModel>[];
    menuItems.add(menuItemWelcome(app, "1", Welcome.identifier, "Welcome"));
    menuItems.add(menuItemShoppingBag(app, "2", Shop.identifier, "Shop"));
    menuItems.add(menuItemAbout(app, "4", About.IDENTIFIER, "About"));
    var menu = MenuDefModel(
        documentID: defaults.homeMenuID(theApp.documentID),
        appId: JUUWLE_APP_ID,
        name: 'Main Menu',
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<AppModel> setupApplication(AppHomePageReferencesModel homePages,
      String ownerID, PublicMediumModel? logo) async {
    var application = AppModel(
      documentID: JUUWLE_APP_ID,
      title: 'Juuwle!',
      description: 'Juuwle',
      logo: logo,
      email: 'juuwle.com.info@gmail.com',
      styleFamily: MonaStyleFamily.monaStyleFamilyName,
      styleName: MonaStyleFamily.juuwleStyleName,
      homePages: homePages,
      ownerID: ownerID,
      appStatus: AppStatus.Live,

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
            MyCart.openCartPage()),
        MenuItemModel(
            documentID: '2',
            text: 'Notifications',
            description: 'Notifications',
            icon: IconModel(
                codePoint: Icons.notifications.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: NotificationDashboard.action(app)),
        MenuItemModel(
            documentID: '3',
            text: 'Members',
            description: 'Members',
            icon: IconModel(
                codePoint: Icons.people.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: MembershipDashboard.action(app)),
        MenuItemModel(
            documentID: '4',
            text: 'Assignments',
            description: 'Assignments',
            icon: IconModel(
                codePoint: Icons.playlist_add_check.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: AssignmentViewSetup.action(app)),
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
