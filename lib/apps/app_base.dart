import 'package:eliud_core/core/access/bloc/access_bloc.dart';
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
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
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
  // adminAppWipers are used to delete the admin part of the app
  List<AdminAppWiperBase> adminAppWipers();
  // adminBase is used to install the admin part of the app
  AdminBase adminBase(DrawerModel drawer, DrawerModel endDrawer);

  Future<void> setupApplication(AppHomePageReferencesModel homePages,
      String? ownerID, MemberMediumModel? logo);
  Future<AppHomePageReferencesModel> runTheRest(String? ownerID,
      DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu);
  Future<AppBarModel> appBar(
      String? appBarIdentifier, MenuDefModel? menu, String? title);
  MenuDefModel drawerMenuDef();
  MenuDefModel profileDrawerMenuDef();
  MenuDefModel homeMenuDef();
  String privacyPolicyAssetLocation();
  String termsOfServiceAssetLocation();
  String disclaimerAssetLocation();

  var theLogo;
  var theLogoHead;

  final String? appId;
  MemberModel? member;
  AppPolicyModel? appPolicyModel;

  // Constructor
  InstallApp({this.appId}) {
  }

  // Implementation
  Future<void> run(String ownerID);

  // Start the installation by claiming ownership of the app.
  // Otherwise you won't be able to add data, given security depends on the ownerId of the app being allowed to add data to app's entities
  // We do this twice: the first time before wiping the data. This is to assure that we can wipe
  // The second time because the wipe has deleted the entry
  // This process works except when the app was create by someone else before. In which case you must delete the app through console.firebase.google.com or by logging in as the owner of the app
  Future<AppModel> claimOwnerShipApplication(
      String? appId, String ownerID) async {
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
    return await accessRepository(appId: appId)!.add(AccessModel(
        documentID: ownerID,
        privilegeLevel: PrivilegeLevel.OwnerPrivilege,
        points: 0));
  }

  PosSizeModel halfScreen() {
    return PosSizeModel(
        documentID: 'halfScreen',
        appId: appId,
        name: 'HalfScreen both orientations',
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
        documentID: 'screen75',
        appId: appId,
        name: '75 % both orientations',
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
        documentID: 'fullScreen',
        appId: appId,
        name: 'Fullscreen both orientations',
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

  Future<void> setupPosSizes() async {
    await corerepo.AbstractRepositorySingleton.singleton
        .posSizeRepository(appId)!
        .add(halfScreen());
    await corerepo.AbstractRepositorySingleton.singleton
        .posSizeRepository(appId)!
        .add(fullScreen());
    await corerepo.AbstractRepositorySingleton.singleton
        .posSizeRepository(appId)!
        .add(screen75());
  }

  Future<MemberMediumModel> _memberMediumModel(String assetLocation) async {
    return await ImageTools.uploadPublicPhoto(appId!, member!, assetLocation);
  }

  DrawerModel _drawer(MemberMediumModel? logo) {
    return DrawerModel(
        documentID: 'DRAWER',
        appId: appId,
        name: 'Drawer',
        headerText: '',
        headerBackgroundOverride: _drawerHeaderBGOverride(logo),
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: drawerMenuDef());
  }

  Future<DrawerModel> setupDrawer(MemberMediumModel? logo) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository(appId)!
        .add(_drawer(logo));
  }

  Future<void> setupDecorationColorModel(MemberMediumModel? logo) async {
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()!
        .add(_drawerHeaderBGOverride(logo));
  }

  BackgroundModel _drawerHeaderBGOverride(MemberMediumModel? logo) {
    var decorationColorModels = <DecorationColorModel>[];
    var backgroundModel = BackgroundModel(
        documentID: 'left_drawer_header_bg',
        decorationColors: decorationColorModels,
        backgroundImageURL: logo != null ? logo.url : null);
    return backgroundModel;
  }

  DrawerModel _profileDrawer() {
    return DrawerModel(
        documentID: 'PROFILE_DRAWER',
        appId: appId,
        name: 'Profile Drawer',
        headerText: '',
        secondHeaderText: 'name: \${userName}\ngroup: \${userGroup}',
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: profileDrawerMenuDef());
  }

  Future<DrawerModel> setupProfileDrawer() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository(appId)!
        .add(_profileDrawer());
  }

  HomeMenuModel homeMenu() {
    var menu = HomeMenuModel(
        documentID: 'MAIN_MENU',
        appId: appId,
        name: 'Home menu 1',
        menu: homeMenuDef(),);
    return menu;
  }

  Future<void> setupMenus() async {
    await corerepo.AbstractRepositorySingleton.singleton
        .homeMenuRepository(appId)!
        .add(homeMenu());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)!
        .add(homeMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)!
        .add(drawerMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)!
        .add(profileDrawerMenuDef());
  }

  DividerModel _divider() {
    var dividerModel = DividerModel(
      documentID: 'divider_1',
      name: 'first divider',
      color: EliudColors.black,
      endIndent: 0,
      height: 10,
      indent: 0,
      thickness: .5,
      appId: appId,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
    return dividerModel;
  }

  Future<void> setupDividers() async {
    await dividerRepository(appId: appId)!.add(_divider());
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
      documentID: documentID,
      appId: appId,
      header: HeaderSelection.None,
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
        .appBarRepository(appId)!
        .add(_appBar(documentID, menu, title, backgroundOverride: backgroundOverride, iconColorOverride: iconColorOverride,
        selectedIconColorOverride: selectedIconColorOverride, menuBackgroundColorOverride: menuBackgroundColorOverride));
  }

  String logoAssetLocation();
  String logoHeadAssetLocation();

  Future<void> runBase({String? ownerID}) async {
/*
    // this code isn't necesairily working correctly: I think it should probably delete all collections, including all packages, and I have the feeling it's not working.
    // however, with the introduction of subcollections for app data, we don't really need this any more, so hence we can skip it
    int i = 0;
    var aaw = adminAppWipers();
    for (int i = 0; i < aaw.length; i++) {
      await aaw[i].deleteAll(appId);
    }
*/
    await setupAppPolicy();
    theLogo = await _memberMediumModel(logoAssetLocation());
    theLogoHead = await _memberMediumModel(logoHeadAssetLocation());
    var endDrawer = await setupProfileDrawer();
    var drawer = await setupDrawer(theLogo);
    var _adminBase = adminBase(drawer, endDrawer);

    await GridViews().run(appId);
    var adminMenu =
        await _appBarMenu("Menu", await _adminBase.installAdminMenus());
    await _adminBase.installAdminAppss(adminMenu);
    await setupMenus();
    await setupPosSizes();
    await setupDecorationColorModel(theLogo);
    await setupDividers();
    var homePages = await runTheRest(ownerID, drawer, endDrawer, adminMenu);
    await setupApplication(homePages, ownerID, theLogoHead);
  }

  Future<void> wipeAndReinstall() async {
    // If I would be logged in > logout (to give the user opportunity to select the user in the signIn)
    await AbstractMainRepositorySingleton.singleton.userRepository()!.signOut();
    var usr = await (AbstractMainRepositorySingleton.singleton
        .userRepository()!
        .signInWithGoogle(null));
    if (usr == null) {
      throw Exception("User is null");
    } else {
      var installedApp = await claimOwnerShipApplication(appId, usr.uid);
      member = await AccessBloc.firebaseToMemberModel(usr);
      if (member == null) {
        print('Can not register $appId because member cannot be created');
      } else {
        await claimAccess(usr.uid);
        await run(usr.uid);
        print('Installed $appId successfully');
      }
    }
  }

  String appBarMenuIdentifier = 'appbar_menu';

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
          action: InternalAction(appId,
              internalActionEnum: InternalActionEnum.Login)),
    );
    menuItems.add(MenuItemModel(
        documentID: '3',
        text: 'Admin',
        description: 'Admin',
        icon: IconModel(
            codePoint: Icons.settings.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(appId, menuDef: adminMenu)));

    var menu = MenuDefModel(
        documentID: appBarMenuIdentifier,
        appId: appId,
        name: title,
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> _appBarMenu(String title, MenuDefModel adminMenu) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)!
        .add(_appBarMenuDef(title, adminMenu));
  }

  // Policy
  static String privacyID = 'privacy_policy';
  static String termsOfServiceID = 'terms_of_service';
  static String disclaimerID = 'disclaimer';

  Future<void> setupAppPolicy() async {
    var privacyPolicy = await ImageTools.uploadPublicPdf(appId!, member!, privacyPolicyAssetLocation(), privacyID);
    var termsOfServicePolicy = await ImageTools.uploadPublicPdf(appId!, member!, termsOfServiceAssetLocation(), termsOfServiceID);
    var disclaimerPolicy = await ImageTools.uploadPublicPdf(appId!, member!, disclaimerAssetLocation(), disclaimerID);

    appPolicyModel = AppPolicyModel(
        documentID: 'policies',
        appId: appId,
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
    await corerepo.appPolicyRepository(appId: appId)!.add(appPolicyModel!);
  }

  Future<List<PageModel>> createPolicyPages(AppPolicyModel appPolicyModel, DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu) async {
    List<PageModel> pages = [];
    appPolicyModel.policies!.forEach((element) async {
       pages.add(await PolicyPage(
          policy: element.policy,
          title: element.name,
          installApp: this,
          homeMenu: homeMenu(),
          drawer: drawer,
          endDrawer: endDrawer,
          adminMenu: adminMenu)
          .run());
    });
    return pages;
  }

  List<MenuItemModel> getPolicyMenuItems() {
    List<MenuItemModel> menuItems = [];
    appPolicyModel!.policies!.forEach((element) async {
      menuItems.add(menuItem(
          appId, element.documentID, element.documentID, element.name, Icons.rule));
    });
    return menuItems;
  }
}
