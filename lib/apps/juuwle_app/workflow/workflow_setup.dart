import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/shared/workflow/workflow_helper.dart';
import 'package:eliud_pkg_shop/shop_package.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';

import '../../install_app.dart';

class WorkflowSetup {
  final InstallApp installApp;

  WorkflowSetup({required this.installApp});

  static WorkflowModel _workflowForCreditCardPaymentCart(String appId) {
    return WorkflowHelper.workflowForCreditCardPaymentCart(appId);
  }

  Future<void> _setupWorkflows() async {
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.theApp.documentID)!
        .add(_workflowForCreditCardPaymentCart(installApp.theApp.documentID));
  }

  static WorkflowActionModel payCart() =>
      WorkflowActionModel(JuuwleApp.app,
          conditions: DisplayConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
          ),
          workflow: _workflowForCreditCardPaymentCart(JuuwleApp.app.documentID));

  Future<void> run() async {
    return await _setupWorkflows();
  }
}
