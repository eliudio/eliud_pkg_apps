import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/workflow/workflow_setup.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/pay_component.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../install_app.dart';
import '../../../shared/etc/page_template.dart';
import '../../juuwle_app.dart';

class MyPay extends PageTemplate {
  final BackgroundModel? background;
  final ShopModel? shop;

  static const String identifier = 'juuwlepay';

  static ActionModel action(String appId) => GotoPage(JuuwleApp.app,
      pageID: MyPay.identifier,
      conditions: DisplayConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
      ));

  PayModel _payModel() {
    return PayModel(
      documentID: 'pay',
      appId: installApp!.theApp.documentID,
      description: pageTitle(),
      shop: shop,
      payAction: WorkflowSetup.payCart(),
      succeeded: GotoPage(JuuwleApp.app,
          pageID: MyPayConfirmation.identifier),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  @override
  String pageTitle() => 'Payment';

  @override
  String pageDescription() => 'Payment';

  @override
  String componentName() => AbstractPayComponent.componentName;

  MyPay({
    this.background,
    this.shop,
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
            privilegeLevelRequired:
                PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
            packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
            pageId: identifier,
            installApp: installApp,
            homeMenu: homeMenu,
            drawer: drawer,
            endDrawer: endDrawer,
            presentationImageAlignment: PresentationImageAlignment.Left);

  @override
  String? componentID() {
    return _payModel().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton
        .payRepository(JuuwleApp.JUUWLE_APP_ID)!
        .add(_payModel());
  }

  @override
  String assetLocation() =>
      'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_with_credit_card.png';
}
