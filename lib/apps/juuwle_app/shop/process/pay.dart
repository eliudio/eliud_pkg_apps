import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/workflow/workflow_setup.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/pay_component.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../shared/etc/page_template.dart';
import '../../juuwle_app.dart';

class MyPay extends PageTemplate {
  final BackgroundModel? background;
  final ShopModel? shop;

  static const String identifier = 'juuwlepay';

  static ActionModel action(String appId) => GotoPage(JuuwleApp.app,
      pageID: MyPay.identifier,
      conditions: DisplayConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
        packageCondition: ShopPackage.conditionCartsHasItems,
      ));

  PayModel _payModel() {
    return PayModel(
      documentID: 'pay',
      appId: installApp!.theApp.documentID,
      description: pageTitle(),
      shop: shop,
      payAction: WorkflowSetup.payCart(),
      succeeded: GotoPage(JuuwleApp.app, pageID: MyPayConfirmation.identifier),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
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
    super.installApp,
    super.homeMenu,
    super.drawer,
    super.endDrawer,
  }) : super(
            privilegeLevelRequired:
                PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
            packageCondition: ShopPackage.conditionCartsHasItems,
            pageId: identifier,
            presentationImageAlignment: PresentationImageAlignment.Left);

  @override
  String? componentID() {
    return _payModel().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton
        .payRepository(JuuwleApp.juuwleAppId)!
        .add(_payModel());
  }

  @override
  String assetLocation() =>
      'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_with_credit_card.png';
}
