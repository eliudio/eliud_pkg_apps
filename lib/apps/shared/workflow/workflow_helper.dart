import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_apps/apps/app_base.dart';
import 'package:eliud_pkg_membership/tools/task/membership_task_model.dart';
import 'package:eliud_pkg_pay/tools/task/pay_task_model.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_task_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';
import 'package:eliud_pkg_membership/membership_package.dart';

class WorkflowHelper {
  static WorkflowModel workflowForManuallyPaidMembership({double amount, String ccy, String payTo, String country, String bankIdentifierCode, String payeeIBAN, String bankName}) {
    return WorkflowModel(
        documentID: "membership_paid_manually",
        name: "Paid Membership (manually paid)",
        workflowTask: [
          WorkflowTaskModel(
            seqNumber: 1,
            documentID: "request_membership",
            responsible: WorkflowTaskResponsible.CurrentMember,
            task: RequestMembershipTaskModel(
                description: 'Please join. It costs 20 GBP, 1 time cost',
            ),
          ),
          WorkflowTaskModel(
            seqNumber: 2,
            documentID: "pay_membership",
            responsible: WorkflowTaskResponsible.CurrentMember,
            task: FixedAmountPayModel(
                description: 'To join, deposit 20 GBP by wired transfer',
                paymentType: ManualPayTypeModel(
                    payTo: payTo,
                    country: country,
                    bankIdentifierCode: bankIdentifierCode,
                    payeeIBAN: payeeIBAN,
                    bankName: bankName),
                ccy: ccy,
                amount: amount),
          ),
          WorkflowTaskModel(
            seqNumber: 3,
            documentID: "confirm_membership",
            responsible: WorkflowTaskResponsible.Owner,
            task: ApproveMembershipTaskModel(
                description: 'Verify payment and confirm membership',
            ),
          ),
        ]);
  }

}
