import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../../apps/app_base.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/pay.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_shop/model/cart_component.dart';
import 'package:eliud_pkg_shop/model/cart_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_shop/model/shop_model.dart';
import 'package:eliud_core/tools/action_model.dart';

import '../../../shared/etc/page_template.dart';
import '../../juuwle_app.dart';

class MyCart extends PageTemplate {
  final BackgroundModel background;
  final ShopModel shop;

  static const String identifier = 'juuwlecart';

  CartModel _cart() {
    return CartModel(
        documentID: 'cart',
        appId: installApp.appId,
        title: pageTitle(),
        description: 'Shopping bag',
        checkoutText: 'Checkout',
        shop: shop,
        itemImageBackground: null,
        itemDetailBackground: background,
        checkoutAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: MyPay.identifier),
        backToShopAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: Shop.identifier),
    );
  }

  @override
  String pageTitle() => 'Your Bag';

  @override
  String pageImageUrl() => 'https://live.staticflickr.com/65535/50014767528_4b6f07c2c9_o_d.png';

  @override
  String pageImageID() => 'cartImage';

  @override
  String componentName() => AbstractCartComponent.componentName;

  MyCart({
    this.background,
    this.shop,
    InstallApp installApp,
    Tools newAppTools,
    HomeMenuModel homeMenu,
    BackgroundModel pageBG,
    DrawerModel drawer,
    DrawerModel endDrawer,
    MenuDefModel adminMenu}): super(
      pageCondition: PageCondition.PackageDecides,
      packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
      pageId: identifier,
      installApp: installApp,
      newAppTools: newAppTools,
      homeMenu: homeMenu,
      pageBG: pageBG,
      drawer: drawer,
      endDrawer: endDrawer,
      adminMenu: adminMenu);

  @override
  String componentID() {
    return _cart().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton.
    cartRepository(JuuwleApp.JUUWLE_APP_ID).add(_cart());
  }
}
