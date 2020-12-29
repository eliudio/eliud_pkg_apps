import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_apps/apps/app_base.dart';
import 'package:eliud_pkg_pay/tools/task/pay_task_model.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_task_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';
import 'package:eliud_pkg_membership/membership_package.dart';

class WorkflowSetup {
  final InstallApp installApp;

  WorkflowSetup({this.installApp});

  static WorkflowModel _workflowModel() {
    return WorkflowModel(
        documentID: "manual_paid_membership",
        name: "Manual Membership (paid)",
        workflowTask: [
          WorkflowTaskModel(
            seqNumber: 1,
            documentID: "workflow_task_payment_manual",
            responsible: WorkflowTaskResponsible.CurrentMember,
            task: FixedAmountPayModel(
                paymentType: ManualPayTypeModel(
                    payTo: "Mr Minkey",
                    country: "United Kingdom",
                    bankIdentifierCode: "Bank ID Code",
                    payeeIBAN: "IBAN 543232187632167",
                    bankName: "Bank Of America"),
                ccy: "GBP",
                amount: 20),
          ),
          WorkflowTaskModel(
            seqNumber: 2,
            documentID: "workflow_task_payment_stripe1",
            responsible: WorkflowTaskResponsible.CurrentMember,
            task: FixedAmountPayModel(
                paymentType: CreditCardPayTypeModel(), ccy: "GBP", amount: 20),
          ),
          WorkflowTaskModel(
            seqNumber: 3,
            documentID: "workflow_task_payment_stripe2",
            responsible: WorkflowTaskResponsible.Owner,
            task: FixedAmountPayModel(
                paymentType: CreditCardPayTypeModel(), ccy: "GBP", amount: 20),
          ),
        ]);
  }

  Future<WorkflowModel> _setupWorkflow() async {
    return await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.appId)
        .add(_workflowModel());
  }

  static WorkflowAction requestMembershipAction(String appId) =>
      WorkflowAction(appId,
          readCondition: ReadCondition.PackageDecides,
          packageCondition: MembershipPackage.MEMBER_HAS_NO_MEMBERSHIP_YET,
          workflow: _workflowModel());

  void run() async {
    await _setupWorkflow();
  }
}
