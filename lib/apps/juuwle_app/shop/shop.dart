import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/apis/style/_default/tools/colors.dart';
import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/decoration_color_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/platform_medium_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core_main/apis/action_api/action_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_fundamentals_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals_model/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/listed_item_model.dart';
import 'package:eliud_pkg_fundamentals_model/model/presentation_component.dart';
import 'package:eliud_pkg_fundamentals_model/model/presentation_model.dart';
import 'package:eliud_pkg_shop/wizards/builders/util/image_tools.dart';
import 'package:eliud_pkg_shop/wizards/builders/util/products.dart';
import 'package:eliud_pkg_shop_model/model/abstract_repository_singleton.dart'
    as shoprepo;
import 'package:eliud_pkg_shop_model/model/model_export.dart';
import 'package:eliud_pkg_shop_model/model/shop_front_component.dart';

import '../../install_app.dart';
import '../../app_section.dart';
import 'process/cart.dart';
import 'product_page.dart';

class Shop extends AppSection {
  Shop({
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  static String identifier = 'juuwleshop';

  static ActionModel action(String appId) => GotoPage(
        JuuwleApp.app,
        pageID: Shop.identifier,
      );

  Future<PageModel> _setupPage(
      AppBarModel appBar, String? presentationDocumentId) async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .pageRepository(JuuwleApp.juuwleAppId)!
        .add(_page(appBar, presentationDocumentId));
  }

  PageModel _page(AppBarModel appBar, String? presentationDocumentId) {
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
        componentId: presentationDocumentId));

    return PageModel(
        documentID: identifier,
        appId: JuuwleApp.juuwleAppId,
        title: 'Shop',
        description: 'Shop',
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
        .faderRepository(JuuwleApp.juuwleAppId)!
        .add(_fader());
  }

  static String faderIdentifier = 'juuwlefader';
  FaderModel _fader() {
    var items = <ListedItemModel>[];
    items.add(ListedItemModel(
        documentID: 'juuwle',
        description: 'Juuwle',
        posSize: installApp!.halfScreen(),
        image: installApp!.thePlatformLogo));
    var model = FaderModel(
      documentID: faderIdentifier,
      description: 'Juuwle Fader',
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: installApp!.theApp.documentID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    return model;
  }

  Future<ShopModel> _setupShop() async {
    return await shoprepo.AbstractRepositorySingleton.singleton
        .shopRepository(JuuwleApp.juuwleAppId)!
        .add(_shop());
  }

  ShopModel _shop() {
    var document = ShopModel(
      documentID: identifier,
      description: 'Main shop',
      shortDescription: 'Main shop',
      currency: 'eur',
      appId: installApp!.theApp.documentID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    return document;
  }

  static String shopFrontIdentifier1 = 'front1';

  ShopFrontModel _shopFront1() {
    return ShopFrontModel(
      documentID: shopFrontIdentifier1,
      appId: installApp!.theApp.documentID,
      title: 'Featured',
      description: 'These are my featured products',
      shop: _shop(),
      addToCartColor: EliudColors.red,
      itemCardBackground: cardBG(),
      buyAction: MyCart.openCartPage(),
      openProductAction:
          GotoPage(JuuwleApp.app, pageID: ProductPage.identifier),
      size: 250,
      cardElevation: 10,
      cardAxisSpacing: 20,
      scrollDirection: ScrollDirection.vertical,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  static String shopFrontIdentifier2 = 'front2';

  ShopFrontModel _shopFront2() {
    return ShopFrontModel(
      documentID: shopFrontIdentifier2,
      appId: installApp!.theApp.documentID,
      title: 'My products',
      description: 'These are my lovely products',
      shop: _shop(),
      addToCartColor: EliudColors.red,
      itemCardBackground: cardBG(),
      buyAction: MyCart.openCartPage(),
      openProductAction:
          GotoPage(JuuwleApp.app, pageID: ProductPage.identifier),
      size: 250,
      cardElevation: 10,
      cardAxisSpacing: 20,
      scrollDirection: ScrollDirection.vertical,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<void> _setupShopFronts() async {
    await shoprepo.AbstractRepositorySingleton.singleton
        .shopFrontRepository(JuuwleApp.juuwleAppId)!
        .add(_shopFront1());
    await shoprepo.AbstractRepositorySingleton.singleton
        .shopFrontRepository(JuuwleApp.juuwleAppId)!
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
      border: true,
      beginGradientPosition: StartGradientPosition.centerLeft,
      endGradientPosition: EndGradientPosition.centerRight,
      decorationColors: decorationColorModels,
    );
    return backgroundModel;
  }

  static String itemBackground = 'card_bg';

  PresentationModel _presentation(PlatformMediumModel memberMediumModel) {
    return PresentationModel(
      documentID: 'shop',
      appId: installApp!.theApp.documentID,
      bodyComponents: [
        BodyComponentModel(
            documentID: '1',
            componentName: AbstractShopFrontComponent.componentName,
            componentId: _shopFront2().documentID)
      ],
      image: memberMediumModel,
      imagePositionRelative: PresentationRelativeImagePosition.aside,
      imageAlignment: PresentationImageAlignment.left,
      imageWidth: .33,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<PresentationModel> _setupPresentation(
      PlatformMediumModel memberMediumModel) async {
    var presentationModel = _presentation(memberMediumModel);
    await AbstractRepositorySingleton.singleton
        .presentationRepository(JuuwleApp.juuwleAppId)!
        .add(presentationModel);
    return presentationModel;
  }

  Future<PlatformMediumModel> uploadImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!.documentID,
        'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_presenting.png',
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  static String appBarIdentifier = 'store';

  Future<ShopModel> run() async {
    var image = await uploadImage();
    var presentationDocumentId = (await _setupPresentation(image)).documentID;
    await _setupShopFronts();
    var appBar = installApp!.appBar();
    var shop = await _setupShop();
    await Products(
            shop: shop,
            uniqueId: newRandomKey(),
            app: installApp!.theApp,
            memberId: installApp!.member!.documentID)
        .run();
    await _setupFader();
    await _setupPage(appBar, presentationDocumentId);
    return shop;
  }
}
