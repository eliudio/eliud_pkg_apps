import 'package:eliud_pkg_apps/apps/eliud_app/welcome/welcome.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/who/who.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_page.dart';
import 'package:eliud_pkg_apps/apps/tools/font_tools.dart';
import 'package:eliud_model/model/app_bar_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/page_model.dart';
import 'package:eliud_model/shared/abstract_repository_singleton.dart';
import 'package:eliud_model/shared/action_model.dart';
import 'package:eliud_model/shared/image_model.dart';
import 'package:eliud_model/shared/icon_model.dart';
import 'package:eliud_model/model/menu_item_model.dart';
import 'package:eliud_model/model/app_model.dart';

import '../app_base.dart';
import 'admin/admin.dart';
import 'hello_world/hello_world.dart';

/* This code cleans the database and generates a hello-eliud app, which includes the admin pages
 * Extend this code to support new components
 */
class EliudApp extends InstallApp {
  static String ELIUD_APP_ID = "ELIUD_APP";

  EliudApp()
      : super(
            appId: ELIUD_APP_ID,
            appColor1: EliudColors.gray,
            appColor2: EliudColors.blackTransparent,
            appColor3: EliudColors.gray,
            appColor4: EliudColors.blackTransparent,
            dividerColor: EliudColors.gray,
            homeMenuIconColor: EliudColors.white,
            homeMenuPopupBGColor: EliudColors.lightRed,
            headerColor1To3: EliudColors.red,
            headerColor4To5: EliudColors.white,
            defaultColor: EliudColors.black,
            highlightColor: EliudColors.green,
            linkColor: EliudColors.ochre);

  @override
  MenuDefModel profileDrawerMenuDef() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Other apps",
        description: "Other apps",
        action:
            InternalAction(internalActionEnum: InternalActionEnum.OtherApps)));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "Sign out",
        description: "Sign out",
        icon: IconModel(codePoint: 0xe879, fontFamily: "MaterialIcons"),
        action: InternalAction(internalActionEnum: InternalActionEnum.Logout)));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "Flush cache",
        description: "Flush cache",
        icon: IconModel(codePoint: 0xe627, fontFamily: "MaterialIcons"),
        action: InternalAction(internalActionEnum: InternalActionEnum.Flush)));
    menuItems.add(MenuItemModel(
        documentID: "4",
        text: "My Space",
        description: "My Space",
        icon: IconModel(codePoint: 0xe8b8, fontFamily: "MaterialIcons"),
        action: GotoPage(pageID: MemberPage.IDENTIFIER)));
    MenuDefModel menu = MenuDefModel(
        documentID: "drawer_profile_menu",
        appId: ELIUD_APP_ID,
        name: "Drawer Profile Menu",
        menuItems: menuItems);
    return menu;
  }

  @override
  MenuDefModel drawerMenuDef() {
    return homeMenuDef().copyWith(documentID: "drawer_menu", name: "Drawer Menu (copy of main menu)");
  }

  @override
  MenuDefModel homeMenuDef() {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Home",
        description: "Home",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(pageID: "welcome")));
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "Hello World",
        description: "Hello World",
        icon: IconModel(codePoint: 0xe83a, fontFamily: "MaterialIcons"),
        action: GotoPage(pageID: "hello_world")));
    menuItems.add(MenuItemModel(
        documentID: "3",
        text: "Advanced",
        description: "Advanced",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(pageID: "advanced")));
    menuItems.add(MenuItemModel(
        documentID: "4",
        text: "Who",
        description: "Who",
        icon: IconModel(codePoint: 0xe7fb, fontFamily: "MaterialIcons"),
        action: GotoPage(pageID: "who")));
    MenuDefModel menu = MenuDefModel(
        documentID: "main",
        appId: ELIUD_APP_ID,
        name: "Main Menu",
        menuItems: menuItems);
    return menu;
  }

/*
  MenuDefModel iconMenuDef(MenuDefModel _adminMenu) {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "2",
        text: "Admin",
        description: "Admin Stuff",
        icon: IconModel(codePoint: 0xe5d4, fontFamily: "MaterialIcons"),
        action: PopupMenu(menuDef: _adminMenu)));
    menuItems.add(MenuItemModel(
        documentID: "1",
        text: "Document 1",
        description: "Document 1",
        icon: IconModel(codePoint: 0xe879, fontFamily: "MaterialIcons"),
        action: InternalAction(internalActionEnum: InternalActionEnum.Login)));
    return MenuDefModel(
        documentID: "ICON_MENU_1",
        appId: ELIUD_APP_ID,
        name: "Menu Definition 1",
        menuItems: menuItems);
  }
*/

  Future<void> setupApplication(
      PageModel homePage, String ownerID, ImageModel logo) {
    AppModel application = AppModel(
      documentID: ELIUD_APP_ID,
      title: "Eliud!",
      description: "Eliud",
      logo: logo,
      email: "eliud.io.info@gmail.com",
      darkOrLight: DarkOrLight.Light,
      entryPage: homePage,
      formBackground: pageBG(),
      formSubmitButtonColor: EliudColors.red,
      formSubmitButtonTextColor: EliudColors.white,
      formGroupTitleColor: EliudColors.red,
      formFieldTextColor: EliudColors.white,
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
      h1:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.h1Label)),
      h2:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.h2Label)),
      h3:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.h3Label)),
      h4:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.h4Label)),
      h5:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.h5Label)),
      fontHighlight1:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.highlightLabel1)),
      fontHighlight2:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.highlightLabel2)),
      fontLink:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.linkLabel)),
      fontText:fontTools.getFont(FontTools.key(FontTools.robotoLabel, FontTools.normalLabel)),
    );

    return AbstractRepositorySingleton.singleton
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
    await Who(
            installApp: this,
            newAppTools: newAppTools,
            homeMenu: homeMenu(),
            pageBG: pageBG(),
            drawer: drawer,
            endDrawer: endDrawer,
            adminMenu: adminMenu)
        .run();
    await HelloWorld(
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

  Future<void> run(String ownerID) async {
    String urlLogo =
        "https://live.staticflickr.com/65535/49606007538_cf3ca070b9_o.png";
    String urlLogoHead =
        "https://live.staticflickr.com/65535/49619576767_19bec81057_o_d.png";

    return await runBase(
      ownerID: ownerID,
      urlLogo: urlLogo,
      urlLogoHead: urlLogoHead,
    );
  }

  @override
  Future<AppBarModel> appBar(
      String identifier, MenuDefModel menu, String title) async {
    return await setupAppBar(
        identifier,
        menu,
        title,
        EliudColors.white,
        appBarBG(),
        EliudColors.white,
        EliudColors.white,
        EliudColors.red,
        EliudColors.gray);
  }
}
