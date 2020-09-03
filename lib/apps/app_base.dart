import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/admin_app.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/backgrounds.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/grid_views.dart';
import 'package:eliud_pkg_apps/apps/tools/font_tools.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/global_data.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/platform/platform.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_fundamentals/model/divider_model.dart';

abstract class InstallApp {
  Future<void> setupApplication(
      PageModel homePage, String ownerID, ImageModel logo);
  AdminBase adminBase(DrawerModel drawer, DrawerModel endDrawer);
  Future<PageModel> runTheRest(
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

  final String appId;

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
  final Tools newAppTools = Tools();
  FontTools fontTools;
  Future<void> run(String ownerID);

  // Start the installation by claiming ownership of the app.
  // Otherwise you won't be able to add data, given security depends on the ownerId of the app being allowed to add data to app's entities
  // We do this twice: the first time before wiping the data. This is to assure that we can wipe
  // The second time because the wipe has deleted the entry
  // This process works except when the app was create by someone else before. In which case you must delete the app through console.firebase.google.com or by logging in as the owner of the app
  Future<AppModel> claimOwnerShipApplication(
      String appId, String ownerID) async {
    var application = AppModel(
      documentID: appId,
      ownerID: ownerID,
    );
    return await AbstractMainRepositorySingleton.singleton
        .appRepository()
        .add(application);
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

  Future<PosSizeModel> setupPosSizes() {
    return corerepo.AbstractRepositorySingleton.singleton
        .posSizeRepository()
        .add(halfScreen())
        .then((_) => corerepo.AbstractRepositorySingleton.singleton
            .posSizeRepository()
            .add(fullScreen()))
        .then((_) => corerepo.AbstractRepositorySingleton.singleton
            .posSizeRepository()
            .add(screen75()));
  }

  static String LOGO_ID = 'logo';
  static String LOGO_HEAD_ID = 'logo_head';

  Future<ImageModel> logoHead(String urlLogoHead) async {
    return await newAppTools.getImgModel(
        name: LOGO_HEAD_ID, appId: appId, url: urlLogoHead);
  }

  Future<ImageModel> logo(String urlLogo) async {
    await _addProfileImage();
    return newAppTools.getImgModel(name: LOGO_ID, appId: appId, url: urlLogo);
  }

  DrawerModel _drawer(ImageModel logo) {
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

  Future<DrawerModel> setupDrawer(ImageModel logo) {
    return corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository()
        .add(_drawer(logo));
  }

  Future<ImageModel> _addProfileImage() {
    return AbstractMainRepositorySingleton.singleton
        .imageRepository()
        .add(_profileImage());
  }

  ImageModel _profileImage() {
    return ImageModel(
        documentID: 'profile_image',
        name: 'Profile Image',
        source: SourceImage.YourProfilePhoto,
        appId: appId);
  }

  BackgroundModel _profileDrawerHeaderBG() {
    var decorationColorModels = <DecorationColorModel>[];
    var backgroundModel = BackgroundModel(
        documentID: 'profile_drawer_header_bg',
        appId: appId,
        decorationColors: decorationColorModels,
        backgroundImage: _profileImage());
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

  Future<void> setupDecorationColorModel(ImageModel logo) async {
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()
        .add(_homeMenuBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()
        .add(_drawerHeaderBG(logo));
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()
        .add(_drawerBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()
        .add(_profileDrawerHeaderBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()
        .add(_profileDrawerBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()
        .add(appBarBG());
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()
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

  BackgroundModel _drawerHeaderBG(ImageModel logo) {
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

  Future<void> setupShadows() {
    return corerepo.AbstractRepositorySingleton.singleton
        .shadowRepository()
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

  Future<DrawerModel> setupProfileDrawer() {
    return corerepo.AbstractRepositorySingleton.singleton
        .drawerRepository()
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

  // TODO: explain what this is for. Apparently it is used. Without the below, the home menu doesn't show. Why?
  MenuDefModel menuDefModel1() {
    var menuItem = MenuItemModel(
        documentID: '1',
        text: 'Logout',
        description: 'Logout',
        icon: IconModel(codePoint: 0xeb44, fontFamily: 'MaterialIcons'),
        action: InternalAction(internalActionEnum: InternalActionEnum.Logout));
    var menuItems = <MenuItemModel>[];
    menuItems.add(menuItem);
    return MenuDefModel(
        documentID: 'menu_def_1',
        appId: appId,
        name: 'Menu Definition 1',
        menuItems: menuItems);
  }

  Future<void> setupMenus() async {
    await corerepo.AbstractRepositorySingleton.singleton
        .homeMenuRepository()
        .add(homeMenu())
        .then((_) => corerepo.AbstractRepositorySingleton.singleton
            .menuDefRepository()
            .add(menuDefModel1()));
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository()
        .add(homeMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository()
        .add(drawerMenuDef());
    await corerepo.AbstractRepositorySingleton.singleton
        .menuDefRepository()
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
    );
    return dividerModel;
  }

  void setupDividers() {
    AbstractRepositorySingleton.singleton.dividerRepository().add(_divider());
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
      RgbModel menuBackgroundColor) {
    return corerepo.AbstractRepositorySingleton.singleton.appBarRepository().add(_appBar(documentID, menu, title, textColor, background, iconColor, menuItemColor, selectedMenuItemColor,  menuBackgroundColor));
  }

  Future<void> installFonts() async {
    await fontTools.installFonts();
  }

  Future<void> runBase(
      {String ownerID, String urlLogo, String urlLogoHead}) async {
    var theLogo = await logo(urlLogo);
    var endDrawer = await setupProfileDrawer();
    var drawer = await setupDrawer(theLogo);
    var _adminBase = adminBase(drawer, endDrawer);

    // wipe the db for this app
    _adminBase.adminAppWipers().forEach((element) async => await element.deleteAll(appId));

    await installFonts();
    await GridViews().run(appId);
    var theLogoHead = await logoHead(urlLogoHead);
    var adminMenu = await _adminBase.run();
    await memberPage(adminMenu, drawer, endDrawer);
    await setupMenus();
    await setupPosSizes();
    await setupShadows();
    await setupDecorationColorModel(theLogo);
    await setupDividers();
    var homePage = await runTheRest(drawer, endDrawer, adminMenu);
    await setupApplication(homePage, ownerID, theLogoHead);
  }

  void wipeAndReinstall() async {
    var usr = await AbstractMainRepositorySingleton.singleton
        .userRepository()
        .signInWithGoogle();
    var installedApp = await claimOwnerShipApplication(appId, usr.uid);
    GlobalData.init(
        LoggedInWithoutMembership(usr: usr, member: null, app: installedApp, details: null, postLoginAction: null));
    await run(usr.uid);
    // ignore: prefer_single_quotes
    print("Installed $appId successfully");
  }

  String appBarMenuIdentifier = 'appbar_menu';

  MenuDefModel _appBarMenu(String title, MenuDefModel adminMenu) {
    var menuItems = <MenuItemModel>[];
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

  Future<MenuDefModel> appBarMenu(String title, MenuDefModel adminMenu) {
    return corerepo.AbstractRepositorySingleton.singleton.menuDefRepository().add(_appBarMenu(title, adminMenu));
  }

}
