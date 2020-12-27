import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_apps/apps/app_base.dart';
import 'package:eliud_pkg_pay/tools/task/pay_task_model.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_task_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model.dart';
import 'package:eliud_pkg_membership/membership_package.dart';

class WorkflowSetup {
  final InstallApp installApp;

  WorkflowSetup({this.installApp});

  static WorkflowModel _workflowModel() {
    return WorkflowModel(
      documentID: "manual_paid_membership",
      name: "Manual Paid_membership",
      workflowTask: [
        WorkflowTaskModel(
          documentID: "workflow_task_payment_manual",
          task: FixedAmountPayModel(paymentType: PaymentType.Manual, ccy: "GBP", amount: 20),
        ),
        WorkflowTaskModel(
          documentID: "workflow_task_payment_stripe",
          task: FixedAmountPayModel(paymentType: PaymentType.Stripe, ccy: "GBP", amount: 20),
        ),
      ]
    );
  }

  Future<WorkflowModel> _setupWorkflow() async {
    return await AbstractRepositorySingleton.singleton.workflowRepository(installApp.appId).add(_workflowModel());
  }

  static WorkflowAction requestMembershipAction(String appId) => WorkflowAction(
      appId,
      readCondition: ReadCondition.PackageDecides,
      packageCondition: MembershipPackage.MEMBER_HAS_NO_MEMBERSHIP_YET,
      workflow: _workflowModel()
  );

  void run() async {
    await _setupWorkflow();
  }
}
