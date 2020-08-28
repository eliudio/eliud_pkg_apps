import 'package:eliud_model/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_model/model/page_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/order_overview_component.dart';

import '../../app_base.dart';
import '../../shared/etc/page_template.dart';

class OrderOverview extends PageTemplate {
  final BackgroundModel background;
  final ShopModel shop;

  static const String identifier = 'juuwleorders';

  OrderOverviewModel _orderOverview() {
    return OrderOverviewModel(
        documentID: 'orders',
        appId: installApp.appId,
        title: pageTitle(),
        shop: shop,
        itemImageBackground: null,
        itemDetailBackground: background
    );
  }

  @override
  String pageTitle() => 'Your Orders';

  @override
  String pageImageUrl() => 'https://live.staticflickr.com/65535/50014767528_4b6f07c2c9_o_d.png';

  @override
  String pageImageID() => 'cartImage';

  @override
  String componentName() => AbstractOrderOverviewComponent.componentName;

  OrderOverview({
    this.background,
    this.shop,
    InstallApp installApp,
    Tools newAppTools,
    HomeMenuModel homeMenu,
    BackgroundModel pageBG,
    DrawerModel drawer,
    DrawerModel endDrawer,
    MenuDefModel adminMenu}): super(
      pageId: identifier,
      pageCondition: PageCondition.Always,
      installApp: installApp,
      newAppTools: newAppTools,
      homeMenu: homeMenu,
      pageBG: pageBG,
      drawer: drawer,
      endDrawer: endDrawer,
      adminMenu: adminMenu);

  @override
  String componentID() {
    return _orderOverview().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton.orderOverviewRepository().add(_orderOverview());
  }
}
