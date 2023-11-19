import 'package:eliud_core_model/model/background_model.dart';
import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/pay.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/cart_component.dart';
import 'package:eliud_pkg_shop/model/cart_model.dart';
import 'package:eliud_pkg_shop/model/shop_model.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../shared/etc/page_template.dart';
import '../../juuwle_app.dart';
import '../product_page.dart';

class MyCart extends PageTemplate {
  final BackgroundModel? background;
  final ShopModel? shop;

  static const String identifier = 'juuwlecart';

  static GotoPage openCartPage() => GotoPage(JuuwleApp.app,
      pageID: MyCart.identifier,
      conditions: DisplayConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
        packageCondition: ShopPackage.conditionCartsHasItems,
      ));

  CartModel _cart() {
    return CartModel(
      documentID: 'cart',
      appId: installApp!.theApp.documentID,
      title: pageTitle(),
      description: 'Shopping bag',
      checkoutText: 'Checkout',
      shop: shop,
      itemImageBackground: null,
      itemDetailBackground: background,
      checkoutAction: MyPay.action(JuuwleApp.juuwleAppId),
      backToShopAction: Shop.action(JuuwleApp.juuwleAppId),
      openProductAction: ProductPage.action(JuuwleApp.juuwleAppId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  @override
  String pageTitle() => 'Your Bag';

  @override
  String pageDescription() => 'Your Bag';

  String pageImageID() => 'cartImage';

  @override
  String componentName() => AbstractCartComponent.componentName;

  MyCart({
    this.background,
    this.shop,
    super.installApp,
    super.homeMenu,
    super.drawer,
    super.endDrawer,
  }) : super(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
/*
      packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
*/
          pageId: identifier,
        );

  @override
  String? componentID() {
    return _cart().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton
        .cartRepository(JuuwleApp.juuwleAppId)!
        .add(_cart());
  }

  @override
  String assetLocation() =>
      'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_with_bags.png';
}
