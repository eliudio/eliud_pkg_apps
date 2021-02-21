import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/backgrounds.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/grid_views.dart';
import 'package:eliud_pkg_apps/apps/tools/font_tools.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_fundamentals/model/divider_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';

abstract class InstallApp {
  // adminAppWipers are used to delete the admin part of the app
  List<AdminAppWiperBase> adminAppWipers();
  // adminBase is used to install the admin part of the app
  AdminBase adminBase(DrawerModel drawer, DrawerModel endDrawer);

  Future<void> setupApplication(
      AppHomePageReferencesModel homePages, String ownerID, MemberMediumModel logo);
  Future<AppHomePageReferencesModel> runTheRest(String ownerID,
      DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu);
  Future<PageModel> memberPage(
      MenuDefModel adminMenu, DrawerModel drawer, DrawerModel endDrawer);
  Future<AppBarModel> appBar(String appBarIdentifier, MenuDefModel menu, String title);
  MenuDefModel drawerMenuDef();
  MenuDefModel profileDrawerMenuDef();
  MenuDefModel homeMenuDef();
//  MenuDefModel iconMenuDef(MenuDefModel _adminMenu);

  // To provide through the constructor
  final RgbModel appColor1;
  final RgbModel appColor2;
  final RgbModel appColor3;
  final RgbModel appColor4;
  final RgbModel dividerColor;
  final RgbModel homeMenuIconColor;
  final RgbModel homeMenuPopupBGColor;
  var theLogo;
  var theLogoHead;

  final String appId;
  MemberModel member;

  // Constructor
  InstallApp({
    this.appId,
    this.appColor1,
    this.appColor2,
    this.appColor3,
    this.appColor4,
    this.dividerColor,
    this.homeMenuIconColor,
    this.homeMenuPopupBGColor,
    RgbModel headerColor1To3,
    RgbModel headerColor4To5,
    RgbModel defaultColor,
    RgbModel highlightColor,
    RgbModel linkColor,
  }) {
    fontTools = FontTools(appId: appId, headerColor1To3: headerColor1To3, headerColor4To5: headerColor4To5, defaultColor: defaultColor, highlightColor: highlightColor, linkColor: linkColor);
  }

  // Implementation
  FontTools fontTools;
  Future<void> run(String ownerID);

  // Start the installation by claiming ownership of the app.
  // Otherwise you won't be able to add data, given security depends on the ownerId of the app being allowed to add data to app's entities
  // We do this twice: the first time before wiping the data. This is to assure that we can wipe
  // The second time because the wipe has deleted the entry
  // This process works except when the app was create by someone else before. In which case you must delete the app through console.firebase.google.com or by logging in as the owner of the app
  Future<AppModel> claimOwnerShipApplication(
      String appId, String ownerID) async {
    // first delete the app
    AppModel oldApp = await appRepository().get(appId);
    if (oldApp != null) {
      await appRepository().delete(oldApp);
    }

    // add the app
    var application = AppModel(
      documentID: appId,
      ownerID: ownerID,
    );
    return await AbstractMainRepositorySingleton.singleton
        .appRepository()
        .add(application);
  }

  Future <AccessModel> claimAccess(String ownerID) async {
    return await accessRepository(appId: appId).add(AccessModel(
        documentID: ownerID,
        privilegeLevel: PrivilegeLevel.OwnerPrivilege,
        points: 0
      )
    );
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
        .posSizeRepository(appId)
        .add(halfScreen());
    await corerepo.AbstractRepositorySingleton.singleton
            .posSizeRepository(appId)
            .add(fullScreen());
    await corerepo.AbstractRepositorySingleton.singleton
            .posSizeRepository(appId)
            .add(screen75());
  }

  Future<MemberMediumModel> _memberMediumModel(String assetLocation) async {
    return await ImageTools.uploadPublicPhoto(appId, member, assetLocation);
  }

  DrawerModel _drawer(MemberMediumModel logo) {
    return DrawerModel(
        documentID: 'DRAWER',
        appId: appId,
        name: 'Drawer',
        background: _drawerBG(),
        headerText: '',
        headerBackground: _drawerHeaderBG(logo),
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: drawerMenuDef());
  }

  Future<DrawerModel> setupDrawer(MemberMediumModel logo) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository(appId)
        .add(_drawer(logo));
  }

/*
  Future<ImageModel> _addProfileImage() async {
    return await AbstractMainRepositorySingleton.singleton
        .imageRepository(appId)
        .add(_profileImage());
  }

  ImageModel _profileImage() {
    return ImageModel(
        documentID: 'profile_image',
        name: 'Profile Image',
        source: SourceImage.YourProfilePhoto,
        appId: appId);
  }

*/
  BackgroundModel _profileDrawerHeaderBG() {
    var decorationColorModels = <DecorationColorModel>[];
    var backgroundModel = BackgroundModel(
        documentID: 'profile_drawer_header_bg',
        appId: appId,
        decorationColors: decorationColorModels,
        useProfilePhotoAsBackground: true);
    return backgroundModel;
  }

  BackgroundModel _drawerBG() {
    var decorationColorModels = <DecorationColorModel>[];
    var decorationColorModel1 =
        DecorationColorModel(documentID: '1', color: appColor2, stop: -1);
    decorationColorModels.add(decorationColorModel1);
    var decorationColorModel2 =
        DecorationColorModel(documentID: '2', color: appColor1, stop: -1);
    decorationColorModels.add(decorationColorModel2);
    var backgroundModel = BackgroundModel(
      documentID: 'left_drawer_bg',
      appId: appId,
      beginGradientPosition: StartGradientPosition.TopLeft,
      endGradientPosition: EndGradientPosition.BottomRight,
      decorationColors: decorationColorModels,
    );
    return backgroundModel;
  }

  Future<void> setupDecorationColorModel(MemberMediumModel logo) async {
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository(appId)
        .add(_homeMenuBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository(appId)
        .add(_drawerHeaderBG(logo));
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository(appId)
        .add(_drawerBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository(appId)
        .add(_profileDrawerHeaderBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository(appId)
        .add(_profileDrawerBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository(appId)
        .add(appBarBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository(appId)
        .add(pageBG());
  }

  BackgroundModel _homeMenuBG() {
    // this is a clone of _pageBG
    var decorationColorModels = <DecorationColorModel>[];
    var decorationColorModel1 = DecorationColorModel(
      documentID: '1',
      color: appColor1,
    );
    decorationColorModels.add(decorationColorModel1);
    var decorationColorModel2 = DecorationColorModel(
      documentID: '2',
      color: appColor2,
    );

    decorationColorModels.add(decorationColorModel2);
    var backgroundModel = BackgroundModel(
      documentID: 'home_menu_bg',
      appId: appId,
      beginGradientPosition: StartGradientPosition.CenterLeft,
      endGradientPosition: EndGradientPosition.CenterRight,
      decorationColors: decorationColorModels,
      shadow: shadowModel(),
    );
    return backgroundModel;
  }

  BackgroundModel _drawerHeaderBG(MemberMediumModel logo) {
    var decorationColorModels = <DecorationColorModel>[];
    var backgroundModel = BackgroundModel(
        documentID: 'left_drawer_header_bg',
        appId: appId,
        decorationColors: decorationColorModels,
        backgroundImage: logo);
    return backgroundModel;
  }

  BackgroundModel _profileDrawerBG() {
    var decorationColorModels = <DecorationColorModel>[];
    var decorationColorModel1 =
        DecorationColorModel(documentID: '1', color: appColor2, stop: -1);
    decorationColorModels.add(decorationColorModel1);
    var decorationColorModel2 =
        DecorationColorModel(documentID: '2', color: appColor1, stop: -1);
    decorationColorModels.add(decorationColorModel2);
    var backgroundModel = BackgroundModel(
      documentID: 'profile_drawer_bg',
      appId: appId,
      beginGradientPosition: StartGradientPosition.TopRight,
      endGradientPosition: EndGradientPosition.BottomLeft,
      decorationColors: decorationColorModels,
    );
    return backgroundModel;
  }

  BackgroundModel pageBG() {
    var decorationColorModels = <DecorationColorModel>[];
    var decorationColorModel1 = DecorationColorModel(
      documentID: '1',
      color: appColor4,
    );
    decorationColorModels.add(decorationColorModel1);
    var decorationColorModel2 = DecorationColorModel(
      documentID: '2',
      color: appColor3,
    );

    decorationColorModels.add(decorationColorModel2);
    var backgroundModel = BackgroundModel(
      documentID: 'page_bg',
      appId: appId,
      beginGradientPosition: StartGradientPosition.CenterLeft,
      endGradientPosition: EndGradientPosition.CenterRight,
      decorationColors: decorationColorModels,
    );
    return backgroundModel;
  }

  ShadowModel shadowModel() {
    var shadowModel = ShadowModel(
        documentID: 'normal_shadow',
        appId: appId,
        comments: 'Normal shadow',
        color: EliudColors.gray,
        offsetDX: 4,
        offsetDY: 3,
        spreadRadius: 7,
        blurRadius: 7);
    return shadowModel;
  }

  Future<void> setupShadows() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .shadowRepository(appId)
        .add(shadowModel());
  }

  BackgroundModel appBarBG() {
    return Backgrounds.gradient(
      appId: appId,
      documentId: 'appbar_bg',
      fromColor: appColor1,
      toColor: appColor2,
      startPosition: StartGradientPosition.TopLeft,
      endPosition: EndGradientPosition.BottomRight,
    );
  }

  DrawerModel _profileDrawer() {
    return DrawerModel(
        documentID: 'PROFILE_DRAWER',
        appId: appId,
        name: 'Profile Drawer',
        background: _profileDrawerBG(),
        headerText: '',
        secondHeaderText: 'name: \${userName}\ngroup: \${userGroup}',
        headerBackground: _profileDrawerHeaderBG(),
        headerHeight: 0,
        popupMenuBackgroundColor: EliudColors.red,
        menu: profileDrawerMenuDef());
  }

  Future<DrawerModel> setupProfileDrawer() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository(appId)
        .add(_profileDrawer());
  }

  HomeMenuModel homeMenu() {
    var menu = HomeMenuModel(
        documentID: 'MAIN_MENU',
        appId: appId,
        name: 'Home menu 1',
        menu: homeMenuDef(),
        iconColor: homeMenuIconColor,
        popupMenuBackgroundColor: homeMenuPopupBGColor,
        background: _homeMenuBG());
    return menu;
  }

  Future<void> setupMenus() async {
    await corerepo.AbstractRepositorySingleton.singleton
        .homeMenuRepository(appId)
        .add(homeMenu());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)
        .add(homeMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)
        .add(drawerMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(appId)
        .add(profileDrawerMenuDef());
  }

  DividerModel _divider() {
    var dividerModel = DividerModel(
      documentID: 'divider_1',
      name: 'first divider',
      color: dividerColor,
      endIndent: 0,
      height: 10,
      indent: 0,
      thickness: .5,
      appId: appId,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
    return dividerModel;
  }

  Future<void> setupDividers() async {
    await dividerRepository(appId: appId).add(_divider());
  }

  AppBarModel _appBar(String documentID, MenuDefModel menu, String title, RgbModel textColor, BackgroundModel background, RgbModel iconColor, RgbModel menuItemColor, RgbModel selectedIconColor, RgbModel menuBackgroundColor) {
    var appBar = AppBarModel(
      documentID: documentID,
      appId: appId,
      header: HeaderSelection.None,
      title: title,
      background: background,
      iconColor: iconColor,
      iconMenu: menu,
      selectedIconColor: selectedIconColor,
      menuBackgroundColor: menuBackgroundColor,
    );
    return appBar;
  }

  Future<AppBarModel> setupAppBar(
      String documentID,
      MenuDefModel menu,
      String title,
      RgbModel textColor,
      BackgroundModel background,
      RgbModel iconColor,
      RgbModel menuItemColor,
      RgbModel selectedMenuItemColor,
      RgbModel menuBackgroundColor) async {
    return await corerepo.AbstractRepositorySingleton.singleton.appBarRepository(appId).add(_appBar(documentID, menu, title, textColor, background, iconColor, menuItemColor, selectedMenuItemColor,  menuBackgroundColor));
  }

  Future<void> installFonts() async {
    await fontTools.installFonts(appId);
  }

  String logoAssetLocation();
  String logoHeadAssetLocation();

  Future<void> runBase(
      {String ownerID}) async {
/*
    // this code isn't necesairily working correctly: I think it should probably delete all collections, including all packages, and I have the feeling it's not working.
    // however, with the introduction of subcollections for app data, we don't really need this any more, so hence we can skip it
    int i = 0;
    var aaw = adminAppWipers();
    for (int i = 0; i < aaw.length; i++) {
      await aaw[i].deleteAll(appId);
    }
*/
    theLogo = await _memberMediumModel(logoAssetLocation());
    theLogoHead = await _memberMediumModel(logoHeadAssetLocation());
    var endDrawer = await setupProfileDrawer();
    var drawer = await setupDrawer(theLogo);
    var _adminBase = adminBase(drawer, endDrawer);

    await installFonts();
    await GridViews().run(appId);
    var adminMenu = await _appBarMenu("Menu", await _adminBase.installAdminMenus());
    await _adminBase.installAdminAppss(adminMenu);
    await memberPage(adminMenu, drawer, endDrawer);
    await setupMenus();
    await setupPosSizes();
    await setupShadows();
    await setupDecorationColorModel(theLogo);
    await setupDividers();
    var homePages = await runTheRest(ownerID, drawer, endDrawer, adminMenu);
    await setupApplication(homePages, ownerID, theLogoHead);
  }

  Future<void> wipeAndReinstall() async {
    // If I would be logged in > logout (to give the user opportunity to select the user in the signIn)
    await AbstractMainRepositorySingleton.singleton
        .userRepository().signOut();
    var usr = await AbstractMainRepositorySingleton.singleton
        .userRepository()
        .signInWithGoogle();
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

  String appBarMenuIdentifier = 'appbar_menu';

  List<MenuItemModel> extraMenuItems();

  MenuDefModel _appBarMenuDef(String title, MenuDefModel adminMenu) {
    List<MenuItemModel> extraItems = extraMenuItems();
    var menuItems = <MenuItemModel>[];
    if (extraItems != null) menuItems.addAll(extraItems);
    menuItems.add(MenuItemModel(
        documentID: '2',
        text: 'Sign in',
        description: 'Sign in',
        action: InternalAction(appId, internalActionEnum: InternalActionEnum.Login)),

    );
    menuItems.add(MenuItemModel(
        documentID: '3',
        text: 'Admin',
        description: 'Admin',
        icon: IconModel(codePoint: Icons.settings.codePoint, fontFamily: Icons.settings.fontFamily),
        action: PopupMenu(appId, menuDef: adminMenu)));

    var menu = MenuDefModel(
        documentID: appBarMenuIdentifier,
        appId: appId,
        name: title,
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> _appBarMenu(String title, MenuDefModel adminMenu) async {
    return await corerepo.AbstractRepositorySingleton.singleton.menuDefRepository(appId).add(_appBarMenuDef(title, adminMenu));
  }

}
