import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart' as shoprepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop_images.dart';
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
import 'package:eliud_pkg_fundamentals/model/presentation_component.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/shop_front_component.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'process/cart.dart';
import 'product_page.dart';

class Shop extends AppSection {
  Shop(
      {InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer,
            adminMenu);

  static String identifier = 'juuwleshop';

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(JuuwleApp.JUUWLE_APP_ID)
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    var components = <BodyComponentModel>[];
    components.add(BodyComponentModel(
        documentID: '1',
        componentName: AbstractFaderComponent.componentName,
        componentId: faderIdentifier));
    components.add(BodyComponentModel(
        documentID: '2',
        componentName: AbstractDividerComponent.componentName,
        componentId: 'divider_1'));
    components.add(BodyComponentModel(
        documentID: '2',
        componentName: AbstractPresentationComponent.componentName,
        componentId: _presentation().documentID));

    return PageModel(
        documentID: identifier,
        appId: JuuwleApp.JUUWLE_APP_ID,
        title: 'Shop',
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  Future<void> _setupFader() async {
    return await AbstractRepositorySingleton.singleton
        .faderRepository(JuuwleApp.JUUWLE_APP_ID)
        .add(_fader());
  }

  static String faderIdentifier = 'juuwlefader';
  FaderModel _fader() {
    var items = <ListedItemModel>[];
    items.add(ListedItemModel(
        documentID: 'juuwle',
        description: 'Juuwle',
        posSize: installApp.halfScreen(),
        image: newAppTools.findImageModel('logo')));
    var model = FaderModel(
      documentID: faderIdentifier,
      name: 'Juuwle Fader',
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: installApp.appId,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
    return model;
  }

  Future<ShopModel> _setupShop() async {
    return await shoprepo.AbstractRepositorySingleton.singleton.shopRepository(JuuwleApp.JUUWLE_APP_ID).add(_shop());
  }

  ShopModel _shop() {
    var document = ShopModel(
        documentID: identifier,
        description: 'Main shop',
        shortDescription: 'Main shop',
        currency: 'eur',
        appId: installApp.appId);
    return document;
  }

  static String shopFrontIdentifier1 = 'front1';

  ShopFrontModel _shopFront1() {
    return ShopFrontModel(
      documentID: shopFrontIdentifier1,
      appId: installApp.appId,
      title: 'Featured',
      description: 'These are my featured products',
      shop: _shop(),
      addToCartColor: EliudColors.red,
      itemCardBackground: cardBG(installApp.appId),
      buyAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: MyCart.identifier),
      view: ShopFrontView.Slider,
      openProductAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: ProductPage.identifier),
      size: 250,
      cardElevation: 10,
      cardAxisSpacing: 20,
      scrollDirection: ScrollDirection.Vertical,
      conditions: ConditionsSimpleModel(
        privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  static String shopFrontIdentifier2 = 'front2';

  ShopFrontModel _shopFront2() {
    return ShopFrontModel(
      documentID: shopFrontIdentifier2,
      appId: installApp.appId,
      title: 'My products',
      description: 'These are my lovely products',
      shop: _shop(),
      addToCartColor: EliudColors.red,
      itemCardBackground: cardBG(installApp.appId),
      buyAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: MyCart.identifier),
      view: ShopFrontView.Grid,
      openProductAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: ProductPage.identifier),
      size: 250,
      cardElevation: 10,
      cardAxisSpacing: 20,
      scrollDirection: ScrollDirection.Vertical,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> _setupShopFronts() async {
    await shoprepo.AbstractRepositorySingleton.singleton.shopFrontRepository(JuuwleApp.JUUWLE_APP_ID).add(_shopFront1());
    await shoprepo.AbstractRepositorySingleton.singleton.shopFrontRepository(JuuwleApp.JUUWLE_APP_ID).add(_shopFront2());
  }

  static BackgroundModel cardBG(String appId) {
    var decorationColorModels = <DecorationColorModel>[];
    var decorationColorModel1 = DecorationColorModel(
      documentID: '1',
      color: EliudColors.white,
    );
    decorationColorModels.add(decorationColorModel1);
    var decorationColorModel2 = DecorationColorModel(
      documentID: '2',
      color: EliudColors.whiteTransparent,
    );

    decorationColorModels.add(decorationColorModel2);
    var backgroundModel = BackgroundModel(
      documentID: itemBackground,
      appId: appId,
      border: true,
      beginGradientPosition: StartGradientPosition.CenterLeft,
      endGradientPosition: EndGradientPosition.CenterRight,
      decorationColors: decorationColorModels,
    );
    return backgroundModel;
  }

  static String itemBackground = 'card_bg';

  Future<void> _setupCardBG() async {
    await corerepo.AbstractRepositorySingleton.singleton.backgroundRepository(JuuwleApp.JUUWLE_APP_ID).add(cardBG(installApp.appId));
  }

  PresentationModel _presentation() {
    return PresentationModel(
        documentID: 'shop',
        appId: installApp.appId,
      bodyComponents: [BodyComponentModel(
          documentID: '1',
          componentName: AbstractShopFrontComponent.componentName,
          componentId: _shopFront2().documentID)],
      image: newAppTools.findImageModel(ShopImages.shopImageId),
      imagePositionRelative: PresentationRelativeImagePosition.Aside,
      imageAlignment: PresentationImageAlignment.Left,
      imageWidth: .33,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> _setupPresentation() async {
    await AbstractRepositorySingleton.singleton.presentationRepository(JuuwleApp.JUUWLE_APP_ID).add(_presentation());
  }

  static String appBarIdentifier = 'store';

  Future<ShopModel> run() async {
    await ShopImages(newAppTools).run();
    await _setupPresentation();
    await _setupCardBG();
    await _setupShopFronts();
//    var appMenu = await installApp.appBarMenu('Basket', adminMenu);
    var appBar = await installApp.appBar(
        identifier,
        adminMenu,
        'Shop');
    var shop = await _setupShop();
    await Products(installApp, newAppTools, shop).run();
    await _setupFader();
    await _setupPage(appBar);
    return shop;
  }
}
