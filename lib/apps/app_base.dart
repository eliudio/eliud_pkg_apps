import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/components/page_constructors/eliud_appbar.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/style/frontend/has_drawer.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_create/tools/defaults.dart' as defaults;
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/grid_views.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/policies/policy_page.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/divider_model.dart';
import 'package:flutter/material.dart';

abstract class InstallApp {
  final AppModel theApp;
  AppBarModel? theAppBar;
  // adminAppWipers are used to delete the admin part of the app
  List<AdminAppWiperBase> adminAppWipers();
  // adminBase is used to install the admin part of the app
  AdminBase adminBase(DrawerModel drawer, DrawerModel endDrawer);

  Future<void> setupApplication(AppHomePageReferencesModel homePages,
      String ownerID, PublicMediumModel? logo);
  Future<AppHomePageReferencesModel> runTheRest(String? ownerID,
      DrawerModel drawer, DrawerModel endDrawer);

  AppBarModel appBar() {
    if (theAppBar == null) {
      throw Exception("theAppBar is not initialised");
    } else {
      return theAppBar!;
    }
  }

  MenuDefModel drawerMenuDef();
  MenuDefModel profileDrawerMenuDef();
  MenuDefModel homeMenuDef();
  String privacyPolicyAssetLocation();
  String termsOfServiceAssetLocation();
  String disclaimerAssetLocation();

  PublicMediumModel? thePublicLogo;
  PublicMediumModel? thePublicLogoHead;
  PlatformMediumModel? thePlatformLogo;

  MemberModel? member;
  AppPolicyModel? appPolicyModel;

  // Constructor
  InstallApp(this.theApp);

  // Implementation
  Future<void> run(String ownerID);

  // Start the installation by claiming ownership of the app.
  // Otherwise you won't be able to add data, given security depends on the ownerId of the app being allowed to add data to app's entities
  // We do this twice: the first time before wiping the data. This is to assure that we can wipe
  // The second time because the wipe has deleted the entry
  // This process works except when the app was create by someone else before. In which case you must delete the app through console.firebase.google.com or by logging in as the owner of the app
  Future<AppModel> claimOwnerShipApplication(
      String appId, String ownerID) async {
    // first delete the app
    AppModel? oldApp = await appRepository()!.get(appId);
    if (oldApp != null) {
      await appRepository()!.delete(oldApp);
    }

    // add the app
    var application = AppModel(
      documentID: appId,
      ownerID: ownerID,
    );
    return await AbstractMainRepositorySingleton.singleton
        .appRepository()!
        .add(application);
  }

  Future<AccessModel> claimAccess(String ownerID) async {
    return await accessRepository(appId: theApp.documentID)!.add(AccessModel(
        documentID: ownerID,
        appId: theApp.documentID,
        privilegeLevel: PrivilegeLevel.OwnerPrivilege,
        points: 0));
  }

  PosSizeModel halfScreen() {
    return PosSizeModel(
        widthPortrait: 1,
        widthTypePortrait: WidthTypePortrait.PercentageWidth,
        heightPortrait: .5,
        heightTypePortrait: HeightTypePortrait.PercentageHeight,
        fitPortrait: PortraitFitType.PortraitFitWidth,
        alignTypePortrait: PortraitAlignType.PortraitAlignCenter,
        widthLandscape: 1,
        widthTypeLandscape: WidthTypeLandscape.PercentageWidth,
        heightLandscape: .5,
        heightTypeLandscape: HeightTypeLandscape.PercentageHeight,
        fitLandscape: LandscapeFitType.LandscapeFitHeight,
        alignTypeLandscape: LandscapeAlignType.LandscapeAlignCenter,
        clip: ClipType.NoClip);
  }

  PosSizeModel screen75() {
    return PosSizeModel(
        widthPortrait: .75,
        widthTypePortrait: WidthTypePortrait.PercentageWidth,
        heightPortrait: .75,
        heightTypePortrait: HeightTypePortrait.PercentageHeight,
        fitPortrait: PortraitFitType.PortraitFitWidth,
        alignTypePortrait: PortraitAlignType.PortraitAlignCenter,
        widthLandscape: .75,
        widthTypeLandscape: WidthTypeLandscape.PercentageWidth,
        heightLandscape: .75,
        heightTypeLandscape: HeightTypeLandscape.PercentageHeight,
        fitLandscape: LandscapeFitType.LandscapeFitHeight,
        alignTypeLandscape: LandscapeAlignType.LandscapeAlignCenter,
        clip: ClipType.NoClip);
  }

  PosSizeModel fullScreen() {
    return PosSizeModel(
        fitLandscape: LandscapeFitType.LandscapeCover,
        widthLandscape: 1,
        heightLandscape: 1,
        heightTypeLandscape: HeightTypeLandscape.PercentageHeight,
        widthTypeLandscape: WidthTypeLandscape.PercentageWidth,
        fitPortrait: PortraitFitType.PortraitFitHeight,
        widthPortrait: 1,
        heightPortrait: 1,
        heightTypePortrait: HeightTypePortrait.PercentageHeight,
        widthTypePortrait: WidthTypePortrait.PercentageWidth,
        clip: ClipType.NoClip);
  }


  Future<PublicMediumModel> _publicMediumModel(String assetLocation) async {
    return await ImageTools.uploadPublicPhoto(theApp, member!, assetLocation);
  }

  Future<PlatformMediumModel> _platformMediumModel(String assetLocation) async {
    return await ImageTools.uploadPlatformPhoto(theApp, member!, assetLocation, PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple);
  }

  DrawerModel _drawer(PublicMediumModel? logo) {
    return DrawerModel(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.Left),
        appId: theApp.documentID,
        name: 'Drawer',
        headerText: '',
        headerBackgroundOverride: _drawerHeaderBGOverride(logo),
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: drawerMenuDef());
  }

  Future<DrawerModel> setupDrawer(PublicMediumModel? logo) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository(theApp.documentID)!
        .add(_drawer(logo));
  }

  BackgroundModel _drawerHeaderBGOverride(PublicMediumModel? logo) {
    if (logo == null) throw Exception("You must provide a logo");
    var decorationColorModels = <DecorationColorModel>[];
    var backgroundModel = BackgroundModel(
        decorationColors: decorationColorModels,
        backgroundImage: logo);
    return backgroundModel;
  }

  DrawerModel _profileDrawer() {
    return DrawerModel(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.Right),
        appId: theApp.documentID,
        name: 'Profile Drawer',
        headerText: '',
        secondHeaderText: 'name: \${userName}\ngroup: \${userGroup}',
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: profileDrawerMenuDef());
  }

  Future<DrawerModel> setupProfileDrawer() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository(theApp.documentID)!
        .add(_profileDrawer());
  }

  HomeMenuModel homeMenu() {
    var menu = HomeMenuModel(
        documentID: defaults.homeMenuID(theApp.documentID),
        appId: theApp.documentID,
        name: 'Home menu 1',
        menu: homeMenuDef(),);
    return menu;
  }

  Future<void> setupMenus() async {
    await corerepo.AbstractRepositorySingleton.singleton
        .homeMenuRepository(theApp.documentID)!
        .add(homeMenu());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(theApp.documentID)!
        .add(homeMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(theApp.documentID)!
        .add(drawerMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(theApp.documentID)!
        .add(profileDrawerMenuDef());
  }

  DividerModel _divider() {
    var dividerModel = DividerModel(
      documentID: 'divider_1',
      description: 'first divider',
      color: EliudColors.black,
      endIndent: 0,
      height: 10,
      indent: 0,
      thickness: .5,
      appId: theApp.documentID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
    return dividerModel;
  }

  Future<void> setupDividers() async {
    await dividerRepository(appId: theApp.documentID)!.add(_divider());
  }

  AppBarModel _appBar(
      String? documentID,
      MenuDefModel? menu,
      String? title,{
      BackgroundModel? backgroundOverride,
      RgbModel? iconColorOverride,
      RgbModel? selectedIconColorOverride,
      RgbModel? menuBackgroundColorOverride}) {
    var appBar = AppBarModel(
      documentID: defaults.appBarID(theApp.documentID),
      appId: theApp.documentID,
      header: HeaderSelection.Title,
      title: title,
      backgroundOverride: backgroundOverride,
      iconColorOverride: iconColorOverride,
      iconMenu: menu,
      selectedIconColorOverride: selectedIconColorOverride,
      menuBackgroundColorOverride: menuBackgroundColorOverride,
    );
    return appBar;
  }

  Future<AppBarModel> setupAppBar(
      String? documentID,
      MenuDefModel? menu,
      String? title,{
      BackgroundModel? backgroundOverride,
      RgbModel? iconColorOverride,
      RgbModel? selectedIconColorOverride,
      RgbModel? menuBackgroundColorOverride}) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .appBarRepository(theApp.documentID)!
        .add(_appBar(documentID, menu, title, backgroundOverride: backgroundOverride, iconColorOverride: iconColorOverride,
        selectedIconColorOverride: selectedIconColorOverride, menuBackgroundColorOverride: menuBackgroundColorOverride));
  }

  String logoAssetLocation();
  String logoHeadAssetLocation();

  Future<void> runBase({required String ownerID}) async {
/*
    // this code isn't necessarily working correctly: I think it should probably delete all collections, including all packages, and I have the feeling it's not working.
    // however, with the introduction of subcollections for app data, we don't really need this any more, so hence we can skip it
    int i = 0;
    var aaw = adminAppWipers();
    for (int i = 0; i < aaw.length; i++) {
      await aaw[i].deleteAll(appId);
    }
*/
    await setupAppPolicy();
    thePublicLogo = await _publicMediumModel(logoAssetLocation());
    thePublicLogoHead = await _publicMediumModel(logoHeadAssetLocation());
    thePlatformLogo = await _platformMediumModel(logoAssetLocation());
    var endDrawer = await setupProfileDrawer();
    var drawer = await setupDrawer(thePublicLogo);
    var _adminBase = adminBase(drawer, endDrawer);

    await GridViews().run(theApp.documentID);
    var adminMenu =
        await _appBarMenu("Menu", await _adminBase.installAdminMenus());

    theAppBar = await setupAppBar(
      "APPBAR",
      adminMenu,
      EliudAppBar.PAGE_TITLE_KEYWORD,
    );

    await _adminBase.installAdminAppss(adminMenu);
    await setupMenus();
    //await setupPosSizes();
    await setupDividers();
    var homePages = await runTheRest(ownerID, drawer, endDrawer);
    await setupApplication(homePages, ownerID, thePublicLogoHead);
  }

  Future<void> wipeAndReinstall() async {
    // If I would be logged in > logout (to give the user opportunity to select the user in the signIn)
    await AbstractMainRepositorySingleton.singleton.userRepository()!.signOut();
    var usr = await (AbstractMainRepositorySingleton.singleton
        .userRepository()!
        .signInWithGoogle());
    if (usr == null) {
      throw Exception("User is null");
    } else {
      await claimOwnerShipApplication(theApp.documentID, usr.uid);
      member = await AccessBloc.firebaseToMemberModel(usr);
      if (member == null) {
        print('Can not register $theApp.documentID because member cannot be created');
      } else {
/*
        var idToken1 = await usr.getIdToken(true);
        var metadata1 = usr.metadata;
        var idTokenResult1 = await usr.getIdTokenResult(true);
        print('BEFORE: ' + idTokenResult1.claims.toString());
*/
        await claimAccess(usr.uid);
/*
        var idToken2 = await usr.getIdToken(true);
        var metadata2 = usr.metadata;
        var idTokenResult2 = await usr.getIdTokenResult(true);
        print('SECOND STEP, claims: ' + idTokenResult2.claims.toString());
*/
        await usr.reload();
/*
        var idToken3 = await usr.getIdToken(true);
        var metadata3 = usr.metadata;
        var idTokenResult3 = await usr.getIdTokenResult(true);
*/
        var idTokenResult = await usr.getIdTokenResult(true);
        print('Claims after claiming access: ' + idTokenResult.claims.toString());
        await run(usr.uid);
        print('Installed $theApp.documentID successfully');
      }
    }
  }

/*
  String appBarMenuIdentifier = 'appbar_menu';

*/
  List<MenuItemModel>? extraMenuItems();

  MenuDefModel _appBarMenuDef(String title, MenuDefModel adminMenu) {
    List<MenuItemModel>? extraItems = extraMenuItems();
    var menuItems = <MenuItemModel>[];
    if (extraItems != null) menuItems.addAll(extraItems);
    menuItems.add(
      MenuItemModel(
          documentID: '2',
          text: 'Sign in',
          description: 'Sign in',
          action: InternalAction(theApp,
              internalActionEnum: InternalActionEnum.Login)),
    );
    menuItems.add(MenuItemModel(
        documentID: '3',
        text: 'Admin',
        description: 'Admin',
        icon: IconModel(
            codePoint: Icons.settings.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(theApp, menuDef: adminMenu)));

    var menu = MenuDefModel(
        documentID: defaults.appBarID(theApp.documentID),
        appId: theApp.documentID,
        name: title,
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> _appBarMenu(String title, MenuDefModel adminMenu) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(theApp.documentID)!
        .add(_appBarMenuDef(title, adminMenu));
  }

  // Policy
  static String privacyID = 'privacy_policy';
  static String termsOfServiceID = 'terms_of_service';
  static String disclaimerID = 'disclaimer';

  Future<void> setupAppPolicy() async {
    var privacyPolicy = await ImageTools.uploadPublicPdf(theApp, member!, privacyPolicyAssetLocation(), privacyID);
    var termsOfServicePolicy = await ImageTools.uploadPublicPdf(theApp, member!, termsOfServiceAssetLocation(), termsOfServiceID);
    var disclaimerPolicy = await ImageTools.uploadPublicPdf(theApp, member!, disclaimerAssetLocation(), disclaimerID);

    appPolicyModel = AppPolicyModel(
        documentID: 'policies',
        appId: theApp.documentID,
        comments: 'All policies of the app',
        policies: [
          AppPolicyItemModel(
            documentID: privacyID,
            name: 'Privacy Policy',
            policy: privacyPolicy,
          ),
          AppPolicyItemModel(
            documentID: termsOfServiceID,
            name: 'Terms of Service',
            policy: termsOfServicePolicy,
          ),
          AppPolicyItemModel(
            documentID: disclaimerID,
            name: 'Disclaimer',
            policy: disclaimerPolicy,
          ),
        ]);
    await corerepo.appPolicyRepository(appId: theApp.documentID)!.add(appPolicyModel!);
  }

  Future<List<PageModel>> createPolicyPages(AppPolicyModel appPolicyModel, DrawerModel drawer,
      DrawerModel endDrawer,
      ) async {
    List<PageModel> pages = [];
    appPolicyModel.policies!.forEach((element) async {
       pages.add(await PolicyPage(
          policy: element.policy,
          title: element.name,
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          )
          .run());
    });
    return pages;
  }

  List<MenuItemModel> getPolicyMenuItems() {
    List<MenuItemModel> menuItems = [];
    appPolicyModel!.policies!.forEach((element) async {
      menuItems.add(menuItem(
          theApp, element.documentID, element.documentID, element.name, Icons.rule));
    });
    return menuItems;
  }
}
