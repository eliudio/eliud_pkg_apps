import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/decoration_color_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/model/shadow_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/play_store_component.dart';
import 'package:eliud_pkg_fundamentals/model/play_store_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'images.dart';

class PlayStore extends AppSection {
  PlayStore({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "playstore";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository().add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "2", componentName: AbstractFaderComponent.componentName, componentId: FADER_IDENTIFIER));
    components.add(BodyComponentModel(
        documentID: "3", componentName: AbstractDividerComponent.componentName, componentId: "divider_1"));
    components.add(BodyComponentModel(
        documentID: "3", componentName: AbstractPlayStoreComponent.componentName, componentId: "playstore_1"));


    return PageModel(
        documentID: IDENTIFIER,
        appId: MinkeyApp.MINKEY_APP_ID,
        title: "Apps",
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditional: PageCondition.Always,
        bodyComponents: components);
  }

  Future<void> _setupFader() async {
    return await AbstractRepositorySingleton.singleton.faderRepository().add(_fader());
  }

  static String FADER_IDENTIFIER = IDENTIFIER;
  FaderModel _fader() {
      List<ListedItemModel> items = List();
      items.add(ListedItemModel(
          documentID: "minkey",
          description: "Minkey",
          posSize: installApp.halfScreen(),
          image: newAppTools.findImageModel("minkey")));
      FaderModel model = FaderModel(
          documentID: FADER_IDENTIFIER,
          name: "Welcome fader",
          animationMilliseconds: 1000,
          imageSeconds: 5,
          animation: FaderAnimation.Fade,
          items: items,
          appId: MinkeyApp.MINKEY_APP_ID,
      );
      return model;
  }

  PlayStoreModel playStore() {
    return PlayStoreModel(
      documentID: "playstore_1",
      appId: MinkeyApp.MINKEY_APP_ID,
      description: "Minkey Store",
      itemBackground: playStoreBG(),
    );
  }

  Future<void> _setupPlayStore() async {
    return await AbstractRepositorySingleton.singleton.playStoreRepository().add(playStore());
  }

  BackgroundModel playStoreBG() {
    // this is a clone of _pageBG
    List<DecorationColorModel> decorationColorModels = List();
    DecorationColorModel decorationColorModel1 = DecorationColorModel(
      documentID: "1",
      color: RgbModel(r: 0xF5, g: 0xEE, b: 0xF5, opacity: 0.30),
    );
    decorationColorModels.add(decorationColorModel1);
    DecorationColorModel decorationColorModel2 = DecorationColorModel(
      documentID: "2",
      color: RgbModel(r: 0xE2, g: 0x47, b: 0x47, opacity: 0.30),
    );

    decorationColorModels.add(decorationColorModel2);
    BackgroundModel backgroundModel =
    BackgroundModel(
      documentID: "playstore_bg",
      appId: MinkeyApp.MINKEY_APP_ID,
      beginGradientPosition: StartGradientPosition.TopLeft,
      endGradientPosition: EndGradientPosition.BottomRight,
      decorationColors: decorationColorModels,
      border: true,
      shadow: _shadowModel(),
    );
    return backgroundModel;
  }

  Future<void> _setupPlayStoreBG() async {
    return await corerepo.AbstractRepositorySingleton.singleton.backgroundRepository().add(playStoreBG());
  }

  ShadowModel _shadowModel() {
    ShadowModel shadowModel =
    ShadowModel(
        documentID: "store_item_shadow",
        appId: MinkeyApp.MINKEY_APP_ID,
        comments: "Store Item shadow",
        color: EliudColors.grayTransparent,
        offsetDX: 4,
        offsetDY: 3,
        spreadRadius: 7,
        blurRadius: 7
    );
    return shadowModel;
  }

  Future<void> _setupShadows() async {
    return await corerepo.AbstractRepositorySingleton.singleton.shadowRepository().add(_shadowModel());
  }

  // ************************ Tutorials *****************
  Future<PageModel> run() async {
    await WhoImages(newAppTools).run();
    await _setupShadows();
    await _setupPlayStore();
    await _setupPlayStoreBG();
//    var appMenu = await installApp.appBarMenu("Play Store", adminMenu);
    var appBar = await installApp.appBar(IDENTIFIER, adminMenu, "Store");
    await _setupFader();
    return await _setupPage(appBar);
  }
}
