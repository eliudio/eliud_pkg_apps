import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_pkg_apps/apps/app_base.dart';
import 'package:eliud_pkg_apps/apps/shared/workflow/workflow_helper.dart';
import 'package:eliud_pkg_shop/shop_package.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';

class WorkflowSetup {
  final InstallApp? installApp;

  WorkflowSetup({this.installApp});

  static WorkflowModel _workflowForCreditCardPaymentCart() {
    return WorkflowHelper.workflowForCreditCardPaymentCart(
    );
  }

  Future<void> _setupWorkflows() async {
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp!.appId)!
        .add(_workflowForCreditCardPaymentCart());
  }

  static WorkflowActionModel payCart(String appId) =>
      WorkflowActionModel(appId,
          conditions: ConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
          ),
          workflow: _workflowForCreditCardPaymentCart());

  Future<void> run() async {
    return await _setupWorkflows();
  }
}
