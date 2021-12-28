import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/cart.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/basic_page_template.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/product_display_component.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../app_base.dart';
import '../juuwle_app.dart';

class ProductPage extends BasicPageTemplate {
  final ShopModel? shop;

  static const String identifier = 'productpage';

  static ActionModel action(String appId) => GotoPage(JuuwleApp.app,
      pageID: ProductPage.identifier,
      conditions: DisplayConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
      ));

  ProductDisplayModel _productDisplayOverview() {
    return ProductDisplayModel(
      documentID: 'product',
      appId: installApp!.theApp.documentID!,
      title: pageTitle(),
      shop: shop,
      buyAction: MyCart.openCartPage(),
      itemDetailBackground: null,
      addToBasketText: 'Add to basket',
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  @override
  String pageTitle() => 'Product';

  @override
  String componentName() => AbstractProductDisplayComponent.componentName;

  ProductPage({
    this.shop,
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          pageId: identifier,
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
          installApp: installApp,
          homeMenu: homeMenu,
          drawer: drawer,
          endDrawer: endDrawer,
        );

  @override
  String? componentID() {
    return _productDisplayOverview().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton
        .productDisplayRepository(JuuwleApp.JUUWLE_APP_ID)!
        .add(_productDisplayOverview());
  }
}
