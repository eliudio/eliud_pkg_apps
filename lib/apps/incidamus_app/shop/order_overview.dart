import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/order_overview_component.dart';

import '../../app_base.dart';
import '../../shared/etc/page_template.dart';
import '../incidamus_app.dart';

class OrderOverview extends PageTemplate {
  final BackgroundModel? background;
  final ShopModel? shop;

  static const String identifier = 'juuwleorders';

  OrderOverviewModel _orderOverview() {
    return OrderOverviewModel(
        documentID: 'orders',
        appId: installApp!.appId,
        title: pageTitle(),
        shop: shop,
        itemImageBackground: null,
        itemDetailBackground: background,
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  @override
  String pageTitle() => 'Your Orders';

  @override
  String componentName() => AbstractOrderOverviewComponent.componentName;

  OrderOverview({
    this.background,
    this.shop,
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,}): super(
      privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
      pageId: identifier,
      installApp: installApp,
      homeMenu: homeMenu,
      drawer: drawer,
      endDrawer: endDrawer,
      );

  @override
  String? componentID() {
    return _orderOverview().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton.orderOverviewRepository(IncidamusApp.INCIDAMUS_APP_ID)!.add(_orderOverview());
  }

  @override
  String assetLocation() => 'packages/eliud_pkg_apps/assets/incidamus_app/decorating/body2.png';
}
