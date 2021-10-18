import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/incidamus_app.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_component.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart'
    as shoprepo;
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/shop_front_component.dart';

import '../../app_base.dart';
import '../../app_section.dart';
import 'process/cart.dart';
import 'product_page.dart';

class Shop extends AppSection {
  Shop(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer,})
      : super(installApp, homeMenu,  drawer, endDrawer,
            );

  static String identifier = 'shop';

  Future<PageModel> _setupPage(AppBarModel appBar, String? presentationDocumentId) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(IncidamusApp.INCIDAMUS_APP_ID)!
        .add(_page(appBar, presentationDocumentId));
  }

  PageModel _page(AppBarModel appBar, String? presentationDocumentId) {
    var components = <BodyComponentModel>[];
    components.add(BodyComponentModel(
        documentID: '2',
        componentName: AbstractPresentationComponent.componentName,
        componentId: presentationDocumentId));

    return PageModel(
        documentID: identifier,
        appId: IncidamusApp.INCIDAMUS_APP_ID,
        title: 'Shop',
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  Future<ShopModel> _setupShop() async {
    return await shoprepo.AbstractRepositorySingleton.singleton
        .shopRepository(IncidamusApp.INCIDAMUS_APP_ID)!
        .add(_shop());
  }

  ShopModel _shop() {
    var document = ShopModel(
        documentID: identifier,
        description: 'Main shop',
        shortDescription: 'Main shop',
        currency: 'eur',
        appId: installApp!.appId);
    return document;
  }

  static String shopFrontIdentifier1 = 'front1';

  ShopFrontModel _shopFront1() {
    return ShopFrontModel(
      documentID: shopFrontIdentifier1,
      appId: installApp!.appId,
      title: 'Featured',
      description: 'These are my featured products',
      shop: _shop(),
      addToCartColor: EliudColors.red,
      itemCardBackground: cardBG(),
      buyAction:
          GotoPage(IncidamusApp.INCIDAMUS_APP_ID, pageID: MyCart.identifier),
      view: ShopFrontView.Slider,
      openProductAction: GotoPage(IncidamusApp.INCIDAMUS_APP_ID,
          pageID: ProductPage.identifier),
      size: 250,
      cardElevation: 10,
      cardAxisSpacing: 20,
      scrollDirection: ScrollDirection.Vertical,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  static String shopFrontIdentifier2 = 'front2';

  ShopFrontModel _shopFront2() {
    return ShopFrontModel(
      documentID: shopFrontIdentifier2,
      appId: installApp!.appId,
      title: 'My photos for sale',
      description: 'Welcome to my shop. Blah blah blah.',
      shop: _shop(),
      addToCartColor: EliudColors.red,
      itemCardBackground: cardBG(),
      buyAction:
          GotoPage(IncidamusApp.INCIDAMUS_APP_ID, pageID: MyCart.identifier),
      view: ShopFrontView.Grid,
      openProductAction: GotoPage(IncidamusApp.INCIDAMUS_APP_ID,
          pageID: ProductPage.identifier),
      size: 250,
      cardElevation: 10,
      cardAxisSpacing: 20,
      scrollDirection: ScrollDirection.Vertical,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<void> _setupShopFronts() async {
    await shoprepo.AbstractRepositorySingleton.singleton
        .shopFrontRepository(IncidamusApp.INCIDAMUS_APP_ID)!
        .add(_shopFront1());
    await shoprepo.AbstractRepositorySingleton.singleton
        .shopFrontRepository(IncidamusApp.INCIDAMUS_APP_ID)!
        .add(_shopFront2());
  }

  static BackgroundModel cardBG() {
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
      border: true,
      beginGradientPosition: StartGradientPosition.CenterLeft,
      endGradientPosition: EndGradientPosition.CenterRight,
      decorationColors: decorationColorModels,
    );
    return backgroundModel;
  }

  static String itemBackground = 'card_bg';

  Future<void> _setupCardBG() async {
    await corerepo.AbstractRepositorySingleton.singleton
        .backgroundRepository()!
        .add(cardBG());
  }

  PresentationModel _presentation(PlatformMediumModel memberMediumModel) {
    return PresentationModel(
      documentID: 'shop',
      title: 'Shop',
      appId: installApp!.appId,
      bodyComponents: [
        BodyComponentModel(
            documentID: '1',
            componentName: AbstractShopFrontComponent.componentName,
            componentId: _shopFront2().documentID)
      ],
      image: memberMediumModel,
      imagePositionRelative: PresentationRelativeImagePosition.Aside,
      imageAlignment: PresentationImageAlignment.Left,
      imageWidth: .33,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<PresentationModel> _setupPresentation(PlatformMediumModel memberMediumModel) async {
    var presentationModel = _presentation(memberMediumModel);
    await AbstractRepositorySingleton.singleton
        .presentationRepository(IncidamusApp.INCIDAMUS_APP_ID)!
        .add(presentationModel);
    return presentationModel;
  }

  Future<PlatformMediumModel> uploadImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.appId!,
        installApp!.member!,
        'packages/eliud_pkg_apps/assets/incidamus_app/decorating/body3b.png');
  }

  static String appBarIdentifier = 'store';

  Future<ShopModel> run() async {
    var image = await uploadImage();
    var presentation = await _setupPresentation(image);
    var presentationDocumentId = presentation.documentID;
    await _setupCardBG();
    await _setupShopFronts();
    var appBar = installApp!.appBar();
    var shop = await _setupShop();
    await Products(installApp, shop).run();
    await _setupPage(appBar, presentationDocumentId);
    return shop;
  }
}
