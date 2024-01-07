import 'package:eliud_core_main/apis/action_api/actions/internal_action.dart';
import 'package:eliud_core_main/apis/style/_default/tools/colors.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core_model/model/abstract_repository_singleton.dart'
    as modelrepo;
import 'package:eliud_core/core/components/page_constructors/eliud_appbar.dart';
import 'package:eliud_core_main/apis/style/frontend/has_drawer.dart';
import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/app_home_page_references_model.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_main/model/decoration_color_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core_main/model/menu_def_model.dart';
import 'package:eliud_core_main/model/menu_item_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/platform_medium_model.dart';
import 'package:eliud_core_main/model/pos_size_model.dart';
import 'package:eliud_core_main/model/public_medium_model.dart';
import 'package:eliud_core_main/model/rgb_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_core_model/model/app_policy_model.dart';
import 'package:eliud_pkg_create/tools/defaults.dart' as defaults;
import 'package:eliud_pkg_apps/apps/shared/etc/grid_views.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/policies/policy_page.dart';
import 'package:eliud_pkg_fundamentals_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals_model/model/divider_model.dart';
import 'package:eliud_pkg_shop/wizards/builders/util/image_tools.dart';
import 'package:flutter/material.dart';

import 'app_base.dart';

abstract class InstallApp extends AppBase {
  List<PageModel>? policyPages;
  AppBarModel? theAppBar;

  Future<void> setupApplication(AppHomePageReferencesModel homePages,
      String ownerID, PublicMediumModel? logo);
  Future<AppHomePageReferencesModel> runTheRest(
      String? ownerID, DrawerModel drawer, DrawerModel endDrawer);

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

  AppPolicyModel? appPolicyModel;

  // Constructor
  InstallApp(super.theApp);

  PosSizeModel halfScreen() {
    return PosSizeModel(
        widthPortrait: 1,
        widthTypePortrait: WidthTypePortrait.percentageWidth,
        heightPortrait: .5,
        heightTypePortrait: HeightTypePortrait.percentageHeight,
        fitPortrait: PortraitFitType.portraitFitWidth,
        alignTypePortrait: PortraitAlignType.portraitAlignCenter,
        widthLandscape: 1,
        widthTypeLandscape: WidthTypeLandscape.percentageWidth,
        heightLandscape: .5,
        heightTypeLandscape: HeightTypeLandscape.percentageHeight,
        fitLandscape: LandscapeFitType.landscapeFitHeight,
        alignTypeLandscape: LandscapeAlignType.landscapeAlignCenter,
        clip: ClipType.noClip);
  }

  PosSizeModel screen75() {
    return PosSizeModel(
        widthPortrait: .75,
        widthTypePortrait: WidthTypePortrait.percentageWidth,
        heightPortrait: .75,
        heightTypePortrait: HeightTypePortrait.percentageHeight,
        fitPortrait: PortraitFitType.portraitFitWidth,
        alignTypePortrait: PortraitAlignType.portraitAlignCenter,
        widthLandscape: .75,
        widthTypeLandscape: WidthTypeLandscape.percentageWidth,
        heightLandscape: .75,
        heightTypeLandscape: HeightTypeLandscape.percentageHeight,
        fitLandscape: LandscapeFitType.landscapeFitHeight,
        alignTypeLandscape: LandscapeAlignType.landscapeAlignCenter,
        clip: ClipType.noClip);
  }

  PosSizeModel fullScreen() {
    return PosSizeModel(
        fitLandscape: LandscapeFitType.landscapeCover,
        widthLandscape: 1,
        heightLandscape: 1,
        heightTypeLandscape: HeightTypeLandscape.percentageHeight,
        widthTypeLandscape: WidthTypeLandscape.percentageWidth,
        fitPortrait: PortraitFitType.portraitFitHeight,
        widthPortrait: 1,
        heightPortrait: 1,
        heightTypePortrait: HeightTypePortrait.percentageHeight,
        widthTypePortrait: WidthTypePortrait.percentageWidth,
        clip: ClipType.noClip);
  }

  Future<PublicMediumModel> _publicMediumModel(String assetLocation) async {
    return await ImageTools.uploadPublicPhoto(
        theApp, member!.documentID, assetLocation);
  }

  Future<PlatformMediumModel> _platformMediumModel(String assetLocation) async {
    return await ImageTools.uploadPlatformPhoto(theApp, member!.documentID,
        assetLocation, PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  DrawerModel _drawer(PublicMediumModel? logo) {
    return DrawerModel(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.left),
        appId: theApp.documentID,
        name: 'Drawer',
        headerText: '',
        headerBackgroundOverride: _drawerHeaderBGOverride(logo),
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: drawerMenuDef());
  }

  Future<DrawerModel> setupDrawer(PublicMediumModel? logo) async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .drawerRepository(theApp.documentID)!
        .add(_drawer(logo));
  }

  BackgroundModel _drawerHeaderBGOverride(PublicMediumModel? logo) {
    if (logo == null) throw Exception("You must provide a logo");
    var decorationColorModels = <DecorationColorModel>[];
    var backgroundModel = BackgroundModel(
        decorationColors: decorationColorModels, backgroundImage: logo);
    return backgroundModel;
  }

  DrawerModel _profileDrawer() {
    return DrawerModel(
        documentID: defaults.drawerID(theApp.documentID, DrawerType.right),
        appId: theApp.documentID,
        name: 'Profile Drawer',
        headerText: '',
        secondHeaderText: 'name: \${userName}\ngroup: \${userGroup}',
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: profileDrawerMenuDef());
  }

  Future<DrawerModel> setupProfileDrawer() async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .drawerRepository(theApp.documentID)!
        .add(_profileDrawer());
  }

  HomeMenuModel homeMenu() {
    var menu = HomeMenuModel(
      documentID: defaults.homeMenuID(theApp.documentID),
      appId: theApp.documentID,
      name: 'Home menu 1',
      menu: homeMenuDef(),
    );
    return menu;
  }

  Future<void> setupMenus() async {
    await mainrepo.AbstractRepositorySingleton.singleton
        .homeMenuRepository(theApp.documentID)!
        .add(homeMenu());
    await mainrepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(theApp.documentID)!
        .add(homeMenuDef());
    await mainrepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(theApp.documentID)!
        .add(drawerMenuDef());
    await mainrepo.AbstractRepositorySingleton.singleton
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
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    return dividerModel;
  }

  Future<void> setupDividers() async {
    await dividerRepository(appId: theApp.documentID)!.add(_divider());
  }

  AppBarModel _appBar(String? documentID, MenuDefModel? menu, String? title,
      {BackgroundModel? backgroundOverride,
      RgbModel? iconColorOverride,
      RgbModel? selectedIconColorOverride,
      RgbModel? menuBackgroundColorOverride}) {
    var appBar = AppBarModel(
      documentID: defaults.appBarID(theApp.documentID),
      appId: theApp.documentID,
      header: HeaderSelection.title,
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
      String? documentID, MenuDefModel? menu, String? title,
      {BackgroundModel? backgroundOverride,
      RgbModel? iconColorOverride,
      RgbModel? selectedIconColorOverride,
      RgbModel? menuBackgroundColorOverride}) async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .appBarRepository(theApp.documentID)!
        .add(_appBar(documentID, menu, title,
            backgroundOverride: backgroundOverride,
            iconColorOverride: iconColorOverride,
            selectedIconColorOverride: selectedIconColorOverride,
            menuBackgroundColorOverride: menuBackgroundColorOverride));
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
    thePublicLogo = await _publicMediumModel(logoAssetLocation());
    thePublicLogoHead = await _publicMediumModel(logoHeadAssetLocation());
    thePlatformLogo = await _platformMediumModel(logoAssetLocation());
    var endDrawer = await setupProfileDrawer();
    var drawer = await setupDrawer(thePublicLogo);

    await GridViews().run(theApp.documentID);
    var menu = await _appBarMenu("Menu");

    theAppBar = await setupAppBar(
      "APPBAR",
      menu,
      EliudAppBar.pageTitleKeyword,
    );
    await setupAppPoliciesAndPages(drawer, endDrawer);

    await setupMenus();
    //await setupPosSizes();
    await setupDividers();
    var homePages = await runTheRest(ownerID, drawer, endDrawer);
    await setupApplication(homePages, ownerID, thePublicLogoHead);
  }

/*
  String appBarMenuIdentifier = 'appbar_menu';

*/
  List<MenuItemModel>? extraMenuItems();

  MenuDefModel _appBarMenuDef(
    String title,
  ) {
    List<MenuItemModel>? extraItems = extraMenuItems();
    var menuItems = <MenuItemModel>[];
    if (extraItems != null) menuItems.addAll(extraItems);
    menuItems.add(
      MenuItemModel(
          documentID: '2',
          text: 'Sign in',
          description: 'Sign in',
          action: InternalAction(theApp,
              internalActionEnum: InternalActionEnum.login)),
    );
    var menu = MenuDefModel(
        documentID: defaults.appBarID(theApp.documentID),
        appId: theApp.documentID,
        name: title,
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> _appBarMenu(
    String title,
  ) async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(theApp.documentID)!
        .add(_appBarMenuDef(
          title,
        ));
  }

  // Policy
  static String privacyID = 'privacy_policy';
  static String termsOfServiceID = 'terms_of_service';
  static String disclaimerID = 'disclaimer';

  Future<void> setupAppPoliciesAndPages(
    DrawerModel drawer,
    DrawerModel endDrawer,
  ) async {
    var privacyPolicy = await ImageTools.uploadPlatformPdf(
        theApp,
        member!.documentID,
        privacyPolicyAssetLocation(),
        privacyID,
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
    var termsOfServicePolicy = await ImageTools.uploadPlatformPdf(
        theApp,
        member!.documentID,
        termsOfServiceAssetLocation(),
        termsOfServiceID,
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
    var disclaimerPolicy = await ImageTools.uploadPlatformPdf(
        theApp,
        member!.documentID,
        disclaimerAssetLocation(),
        disclaimerID,
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);

    var privacyPolicyModel = AppPolicyModel(
        documentID: privacyID,
        appId: theApp.documentID,
        name: 'Privacy Policy',
        policy: privacyPolicy);
    await modelrepo
        .appPolicyRepository(appId: theApp.documentID)!
        .add(privacyPolicyModel);
    var termsOfServiceModel = AppPolicyModel(
        documentID: termsOfServiceID,
        appId: theApp.documentID,
        name: 'Terms of Service',
        policy: termsOfServicePolicy);
    await modelrepo
        .appPolicyRepository(appId: theApp.documentID)!
        .add(termsOfServiceModel);
    var disclaimerModel = AppPolicyModel(
        documentID: disclaimerID,
        appId: theApp.documentID,
        name: 'Disclaimer',
        policy: disclaimerPolicy);
    await modelrepo
        .appPolicyRepository(appId: theApp.documentID)!
        .add(disclaimerModel);

    policyPages = [];
    policyPages!.add(await PolicyPage(
      policy: privacyPolicyModel,
      installApp: this,
      homeMenu: homeMenu(),
      drawer: drawer,
      endDrawer: endDrawer,
    ).run());
    policyPages!.add(await PolicyPage(
      policy: termsOfServiceModel,
      installApp: this,
      homeMenu: homeMenu(),
      drawer: drawer,
      endDrawer: endDrawer,
    ).run());
    policyPages!.add(await PolicyPage(
      policy: disclaimerModel,
      installApp: this,
      homeMenu: homeMenu(),
      drawer: drawer,
      endDrawer: endDrawer,
    ).run());
  }

  List<MenuItemModel> getPolicyMenuItems() {
    List<MenuItemModel> menuItems = [];
    menuItems.add(menuItem(
        theApp, privacyID, privacyID, 'Privacy Policy', Icons.account_balance));
    menuItems.add(menuItem(theApp, termsOfServiceID, termsOfServiceID,
        'Terms of Service', Icons.account_balance));
    menuItems.add(menuItem(theApp, disclaimerID, disclaimerID, 'Disclaimer',
        Icons.account_balance));
    return menuItems;
  }
}
