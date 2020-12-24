import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/cart.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/basic_page_template.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/product_display_component.dart';

import '../../app_base.dart';
import '../juuwle_app.dart';

class ProductPage extends BasicPageTemplate {
  final ShopModel shop;

  static const String identifier = 'productpage';

  ProductDisplayModel _productDisplayOverview() {
    return ProductDisplayModel(
      documentID: 'product',
      appId: installApp.appId,
      title: pageTitle(),
      shop: shop,
      buyAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: MyCart.identifier),
      itemDetailBackground: installApp.pageBG(),
      addToBasketText: 'Add to basket',
    );
  }

  @override
  String pageTitle() => 'Product';

  @override
  String componentName() => AbstractProductDisplayComponent.componentName;

  ProductPage({
    this.shop,
    InstallApp installApp,
    Tools newAppTools,
    HomeMenuModel homeMenu,
    BackgroundModel pageBG,
    DrawerModel drawer,
    DrawerModel endDrawer,
    MenuDefModel adminMenu}): super(
      pageId: identifier,
      pageCondition: ReadCondition.NoRestriction,
      installApp: installApp,
      newAppTools: newAppTools,
      homeMenu: homeMenu,
      pageBG: pageBG,
      drawer: drawer,
      endDrawer: endDrawer,
      adminMenu: adminMenu);

  @override
  String componentID() {
    return _productDisplayOverview().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton.productDisplayRepository(JuuwleApp.JUUWLE_APP_ID).add(_productDisplayOverview());
  }
}
