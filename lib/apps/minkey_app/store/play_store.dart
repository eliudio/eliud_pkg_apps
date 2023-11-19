import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core_model/model/background_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/decoration_color_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core_model/model/rgb_model.dart';
import 'package:eliud_core/model/shadow_model.dart';
import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';
import 'package:eliud_pkg_create/model/play_store_component.dart';
import 'package:eliud_pkg_create/model/play_store_model.dart';
import 'package:eliud_pkg_create/model/abstract_repository_singleton.dart'
    as creator;

import '../../install_app.dart';
import '../../app_section.dart';

class PlayStore extends AppSection {
  PlayStore(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(installApp, homeMenu, drawer, endDrawer);

  static String identifier = "playstore";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "2",
        componentName: AbstractFaderComponent.componentName,
        componentId: faderIdentifier));
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractDividerComponent.componentName,
        componentId: "divider_1"));
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractPlayStoreComponent.componentName,
        componentId: "playstore_1"));

    return PageModel(
        documentID: identifier,
        appId: MinkeyApp.minkeyAppId,
        title: "Apps",
        description: "Apps",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  Future<FaderModel> _setupFader() async {
    return await AbstractRepositorySingleton.singleton
        .faderRepository(installApp!.theApp.documentID)!
        .add(_fader());
  }

  static String faderIdentifier = identifier;
  FaderModel _fader() {
    List<ListedItemModel> items = [];
    items.add(ListedItemModel(
        documentID: "minkey",
        description: "Minkey",
        posSize: installApp!.halfScreen(),
        image: installApp!.thePlatformLogo));
    FaderModel model = FaderModel(
      documentID: faderIdentifier,
      description: "Welcome fader",
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: MinkeyApp.minkeyAppId,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    return model;
  }

  PlayStoreModel playStore() {
    return PlayStoreModel(
      documentID: "playstore_1",
      appId: MinkeyApp.minkeyAppId,
      description: "Minkey Store",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<PlayStoreModel> _setupPlayStore() async {
    return await creator.AbstractRepositorySingleton.singleton
        .playStoreRepository(installApp!.theApp.documentID)!
        .add(playStore());
  }

  BackgroundModel playStoreBG() {
    // this is a clone of _pageBG
    List<DecorationColorModel> decorationColorModels = [];
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
    BackgroundModel backgroundModel = BackgroundModel(
      beginGradientPosition: StartGradientPosition.topLeft,
      endGradientPosition: EndGradientPosition.bottomRight,
      decorationColors: decorationColorModels,
      border: true,
      shadow: _shadowModel(),
    );
    return backgroundModel;
  }

  ShadowModel _shadowModel() {
    ShadowModel shadowModel = ShadowModel(
        color: EliudColors.grayTransparent,
        offsetDX: 4,
        offsetDY: 3,
        spreadRadius: 7,
        blurRadius: 7);
    return shadowModel;
  }

  // ************************ Tutorials *****************
  Future<PageModel> run() async {
    await _setupPlayStore();
    var appBar = installApp!.appBar();
    await _setupFader();
    return await _setupPage(appBar);
  }
}
