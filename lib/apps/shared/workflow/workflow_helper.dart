import 'package:eliud_pkg_membership/tools/task/membership_task_model.dart';
import 'package:eliud_pkg_pay/tools/task/pay_task_model.dart';
import 'package:eliud_pkg_pay/tools/task/pay_type_model.dart';
import 'package:eliud_pkg_pay/tools/task/review_and_ship_task_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_task_model.dart';

class WorkflowHelper {
  static WorkflowModel _workflowForPaymentCart(String documentID, String name, PayTypeModel payTypeModel) {
    return WorkflowModel(
        documentID: "cart_paid_manually",
        name: "Manual Cart Payment",
        workflowTask: [
          WorkflowTaskModel(
            seqNumber: 1,
            documentID: "workflow_task_payment",
            responsible: WorkflowTaskResponsible.CurrentMember,
            task: ContextAmountPayModel(
              description: 'Please pay for your buy',
              paymentType: payTypeModel,
            ),
          ),
          WorkflowTaskModel(
            seqNumber: 2,
            documentID: "review_payment_and_ship",
            responsible: WorkflowTaskResponsible.Owner,
            task: ReviewAndShipTaskModel(
              description: 'Review the payment and ship the products',
            ),
          ),
        ]);
  }

  static WorkflowModel workflowForManualPaymentCart({String payTo, String country, String bankIdentifierCode, String payeeIBAN, String bankName}) {
    return _workflowForPaymentCart("cat_paid_manually", "Manual Cart Payment", ManualPayTypeModel(
        payTo: payTo,
        country: country,
        bankIdentifierCode: bankIdentifierCode,
        payeeIBAN: payeeIBAN,
        bankName: bankName));
  }

  static WorkflowModel workflowForCreditCardPaymentCart() {
    return _workflowForPaymentCart("cart_paid_by_card", "Cart Payment with Card", CreditCardPayTypeModel());
  }

  static WorkflowModel _workflowForMembership(String documentID, String name, double amount, String ccy, PayTypeModel payTypeModel) {
    return WorkflowModel(
        documentID: documentID,
        name: name,
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
                description: 'To join, pay 20 GBP',
                paymentType: payTypeModel,
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

  static WorkflowModel workflowForManuallyPaidMembership({double amount, String ccy, String payTo, String country, String bankIdentifierCode, String payeeIBAN, String bankName}) {
    return _workflowForMembership("membership_paid_manually", "Paid Membership (manually paid)", 20, "GBP", ManualPayTypeModel(
        payTo: payTo,
        country: country,
        bankIdentifierCode: bankIdentifierCode,
        payeeIBAN: payeeIBAN,
        bankName: bankName));
  }

  static WorkflowModel workflowForMembershipPaidByCard({double amount, String ccy}) {
    return _workflowForMembership("membership_paid_manually", "Paid Membership (manually paid)", 20, "GBP", CreditCardPayTypeModel(requiresConfirmation: true));
  }
}
