import 'package:eliud_core_main/apis/action_api/action_model.dart';
import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/model/display_conditions_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/cart.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/basic_page_template.dart';
import 'package:eliud_pkg_shop_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop_model/model/model_export.dart';
import 'package:eliud_pkg_shop_model/model/product_display_component.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../juuwle_app.dart';

class ProductPage extends BasicPageTemplate {
  final ShopModel? shop;

  static const String identifier = 'productpage';

  static ActionModel action(String appId) => GotoPage(JuuwleApp.app,
      pageID: ProductPage.identifier,
      conditions: DisplayConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
        packageCondition: ShopPackage.conditionCartsHasItems,
      ));

  ProductDisplayModel _productDisplayOverview() {
    return ProductDisplayModel(
      documentID: 'product',
      appId: installApp!.theApp.documentID,
      description: pageTitle(),
      shop: shop,
      buyAction: MyCart.openCartPage(),
      itemDetailBackground: null,
      addToBasketText: 'Add to basket',
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  @override
  String pageTitle() => 'Product';

  @override
  String componentName() => AbstractProductDisplayComponent.componentName;

  ProductPage({
    this.shop,
    super.installApp,
    super.homeMenu,
    super.drawer,
    super.endDrawer,
  }) : super(
          pageId: identifier,
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        );

  @override
  String? componentID() {
    return _productDisplayOverview().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton
        .productDisplayRepository(JuuwleApp.juuwleAppId)!
        .add(_productDisplayOverview());
  }
}
