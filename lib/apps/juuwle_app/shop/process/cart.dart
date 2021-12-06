import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/pay.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/cart_component.dart';
import 'package:eliud_pkg_shop/model/cart_model.dart';
import 'package:eliud_pkg_shop/model/shop_model.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../../apps/app_base.dart';
import '../../../shared/etc/page_template.dart';
import '../../juuwle_app.dart';
import '../product_page.dart';

class MyCart extends PageTemplate {
  final BackgroundModel? background;
  final ShopModel? shop;

  static const String identifier = 'juuwlecart';

  CartModel _cart() {
    return CartModel(
        documentID: 'cart',
        appId: installApp!.appId,
        title: pageTitle(),
        description: 'Shopping bag',
        checkoutText: 'Checkout',
        shop: shop,
        itemImageBackground: null,
        itemDetailBackground: background,
        checkoutAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: MyPay.identifier),
        backToShopAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: Shop.identifier),
        openProductAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: ProductPage.identifier),
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  @override
  String pageTitle() => 'Your Bag';

  @override
  String pageImageID() => 'cartImage';

  @override
  String componentName() => AbstractCartComponent.componentName;

  MyCart({
    this.background,
    this.shop,
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
    }): super(
      privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
/*
      packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
*/
      pageId: identifier,
      installApp: installApp,
      homeMenu: homeMenu,
      drawer: drawer,
      endDrawer: endDrawer,
      );

  @override
  String? componentID() {
    return _cart().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton.
    cartRepository(JuuwleApp.JUUWLE_APP_ID)!.add(_cart());
  }

  @override
  String assetLocation() => 'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_with_bags.png';
}
