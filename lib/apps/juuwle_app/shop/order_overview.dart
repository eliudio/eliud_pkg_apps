import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_shop_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop_model/model/model_export.dart';
import 'package:eliud_pkg_shop_model/model/order_overview_component.dart';

import '../../shared/etc/page_template.dart';
import '../juuwle_app.dart';

class OrderOverview extends PageTemplate {
  final BackgroundModel? background;
  final ShopModel? shop;

  static const String identifier = 'juuwleorders';

  OrderOverviewModel _orderOverview() {
    return OrderOverviewModel(
      documentID: 'orders',
      appId: installApp!.theApp.documentID,
      description: pageTitle(),
      shop: shop,
      itemImageBackground: null,
      itemDetailBackground: background,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  @override
  String pageTitle() => 'Your Orders';

  @override
  String pageDescription() => 'Your Orders';

  @override
  String componentName() => AbstractOrderOverviewComponent.componentName;

  OrderOverview({
    this.background,
    this.shop,
    super.installApp,
    super.homeMenu,
    super.drawer,
    super.endDrawer,
  }) : super(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
          pageId: identifier,
        );

  @override
  String? componentID() {
    return _orderOverview().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton
        .orderOverviewRepository(JuuwleApp.juuwleAppId)!
        .add(_orderOverview());
  }

  @override
  String assetLocation() =>
      'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_with_bags.png';
}
