import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_home_page_references_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/order_overview.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/process/cart.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/process/pay.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/workflow/workflow_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/assignments/assignment_view_setup.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/follow/follow_dashboards.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_model.dart';
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:eliud_stl_mona/mona_style.dart';
import 'package:eliud_stl_mona/mona_style_family.dart';
import 'package:flutter/material.dart';

import '../app_base.dart';
import 'about/about.dart';
import 'admin/admin.dart';
import 'album/album.dart';
import 'assignments/assignments.dart';
import 'blocked/blocked.dart';
import 'feed/feed.dart';
import 'follow/follow_dashboards.dart';
import 'member/incidamus_member_dashboard.dart';
import 'membership/membership_dashboard.dart';
import 'notifications/notification_dashboard.dart';

/* This code cleans the database and generates the incidamus app, which includes the admin pages
 */
class IncidamusApp extends InstallApp {
  static String INCIDAMUS_APP_ID = "INCIDAMUS_APP";

  IncidamusApp()
      : super(
            appId: INCIDAMUS_APP_ID,
            );

  @override
  MenuDefModel profileDrawerMenuDef() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(menuItemSignOut(appId, "SIGN_OUT"));
    menuItems.add(menuItemManageAccount(appId, "MANAGE_ACCOUNT", MemberDashboard.IDENTIFIER));

    MenuDefModel menu = MenuDefModel(
        documentID: "drawer_profile_menu",
        appId: INCIDAMUS_APP_ID,
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
    menuItems.add(menuItemWelcome(
        appId, Welcome.IDENTIFIER, Welcome.IDENTIFIER, "Welcome"));
    menuItems.add(menuItem(appId, "album", Album.IDENTIFIER, "Album", Icons.photo));
    menuItems.add(menuItemShoppingBag(appId, "shop", Shop.identifier, "Shop"));
    menuItems.add(menuItemAbout(appId, "about", About.IDENTIFIER, "About"));
    menuItems.add(menuItemFeed(appId, "feed", Feed.IDENTIFIER, "Feed"));
    MenuDefModel menu = MenuDefModel(
        documentID: "main",
        appId: INCIDAMUS_APP_ID,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  Future<AppModel> setupApplication(AppHomePageReferencesModel homePages,
      String? ownerID, MemberMediumModel? logo) async {
    AppModel application = AppModel(
      documentID: INCIDAMUS_APP_ID,
      title: "Incidamus!",
      description: "Incidamus",
      logo: logo,
      email: "ex.incidamus@gmail.com",
      homePages: homePages,
      styleFamily: MonaStyleFamily.monaStyleFamilyName,
      styleName: MonaStyleFamily.incidamusStyleName,
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
    ];
  }

  @override
  Future<AppHomePageReferencesModel> runTheRest(String? ownerID,
      DrawerModel drawer, DrawerModel endDrawer) async {
    await Welcome(
        installApp: this,
        homeMenu: homeMenu(),
        drawer: drawer,
        endDrawer: endDrawer)
        .run();
    var member = await (AbstractMainRepositorySingleton.singleton
        .memberRepository()!
        .get(ownerID));
    if (member == null) {
      throw Exception("Can't find member");
    } else {
      await createFollowMenu();
      var shop = await Shop(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          )
          .run();
      await WorkflowSetup(installApp: this).run();
      await Feed(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          )
          .run(member);
      await Album(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          )
          .run(member);
      await About(
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
      await IncidamusNotificationDashboard(
          installApp: this,
          )
          .run();
      await IncidamusMembershipDashboard(
          installApp: this,
          )
          .run();
      await IncidamusMemberDashboard(
          installApp: this,
          )
          .run();
      await IncidamusAssignmentViewSetup(
          installApp: this,
          )
          .run();
      await IncidamusFollowDashboards(
          installApp: this,
          )
          .run();
      var homePageBlockedMember = await IncidamusBlocked(
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          )
          .run();
      await createPolicyPages(appPolicyModel!, drawer, endDrawer, );
      AppHomePageReferencesModel homePages = AppHomePageReferencesModel(
        homePageBlockedMember: homePageBlockedMember.documentID,
        homePagePublic: Welcome.IDENTIFIER,
        homePageSubscribedMember: Welcome.IDENTIFIER,
        homePageLevel1Member: Welcome.IDENTIFIER,
        homePageLevel2Member: Welcome.IDENTIFIER,
        homePageOwner: Welcome.IDENTIFIER,
      );
      return homePages;
    }
  }

  static String FOLLOW_MENU_ID = "followMenu";
  MenuDefModel followMenu() {
    var menuItems = <MenuItemModel>[
      MenuItemModel(
          documentID: '1',
          text: 'Follow requests',
          description: 'Follow requests',
          icon: IconModel(
              codePoint: Icons.favorite_border.codePoint,
              fontFamily: Icons.notifications.fontFamily),
          action: OpenDialog(
            IncidamusApp.INCIDAMUS_APP_ID,
            dialogID: FollowRequestDashboard.FOLLOW_REQUEST_IDENTIFIER,
          )),
      menuItemFollowers(appId, "2", FollowDashboards.FOLLOWERS_IDENTIFIER, PrivilegeLevelRequired.Level1PrivilegeRequired),
      menuItemFollowing(appId, "3", FollowDashboards.FOLLOWING_IDENTIFIER, PrivilegeLevelRequired.Level1PrivilegeRequired),
      menuItemFiendFriends(appId, "4", InviteDashboard.INVITE_IDENTIFIER, PrivilegeLevelRequired.Level1PrivilegeRequired),
      MenuItemModel(
          documentID: '5',
          text: 'Members of the app',
          description: 'Members of the app',
          icon: IconModel(
              codePoint: Icons.people.codePoint,
              fontFamily: Icons.notifications.fontFamily),
          action: OpenDialog(
            IncidamusApp.INCIDAMUS_APP_ID,
            conditions: ConditionsModel(
                privilegeLevelRequired:
                    PrivilegeLevelRequired.Level1PrivilegeRequired,
                packageCondition: CorePackage.MUST_BE_LOGGED_ON),
            dialogID: MembershipDashboard.IDENTIFIER,
          )),
    ];
    MenuDefModel menu = MenuDefModel(
        documentID: "followMenu",
        appId: INCIDAMUS_APP_ID,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> createFollowMenu() async {
    return await AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)!
        .add(followMenu());
  }

  Future<void> run(String ownerID) async {
    return await runBase(
        ownerID: ownerID);
  }

  @override
  List<MenuItemModel> extraMenuItems() => <MenuItemModel>[
    MenuItemModel(
        documentID: 'bag',
        text: 'Your bag',
        description: 'Your bag',
        icon: IconModel(
            codePoint: Icons.shopping_basket.codePoint,
            fontFamily: Icons.shopping_basket.fontFamily),
        action:
        GotoPage(IncidamusApp.INCIDAMUS_APP_ID, pageID: MyCart.identifier)),
    MenuItemModel(
        documentID: 'feed',
        text: 'Post',
        description: 'Post this page to my feed',
        icon: IconModel(
            codePoint: Icons.post_add.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: PostActionModel(
            IncidamusApp.INCIDAMUS_APP_ID,
            feed: Feed.feedModel(),
            conditions: ConditionsModel(
              privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
              packageCondition: CorePackage.MUST_BE_LOGGED_ON
            )
        )),
    MenuItemModel(
        documentID: 'notifications',
        text: 'Notifications',
        description: 'Notifications',
        icon: IconModel(
            codePoint: Icons.notifications.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: OpenDialog(IncidamusApp.INCIDAMUS_APP_ID,
            dialogID: NotificationDashboard.IDENTIFIER)),
    MenuItemModel(
        documentID: 'assignments',
        text: 'Assignments',
        description: 'Assignments',
        icon: IconModel(
            codePoint: Icons.playlist_add_check.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: OpenDialog(IncidamusApp.INCIDAMUS_APP_ID,
            dialogID: AssignmentViewSetup.IDENTIFIER)),
    MenuItemModel(
        documentID: 'member_area',
        text: 'Members area',
        description: 'Members area',
        icon: IconModel(
            codePoint: Icons.favorite_border.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: PopupMenu(IncidamusApp.INCIDAMUS_APP_ID, menuDef: followMenu())),
    MenuItemModel(
        documentID: "join",
        text: "JOIN",
        description: "Request membership",
        icon: null,
        action:
            WorkflowSetup.requestMembershipAction(IncidamusApp.INCIDAMUS_APP_ID))
    ];

  @override
  String logoAssetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/logos/logo.png';

  @override
  String logoHeadAssetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/logos/logo_head.png';

  // Policies
  @override
  String privacyPolicyAssetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/legal/Incidamus-Privacy-Policy.pdf';

  @override
  String termsOfServiceAssetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/legal/Incidamus-Terms-of-Service.pdf';

  @override
  String disclaimerAssetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/legal/Incidamus-Disclaimer.pdf';
}
