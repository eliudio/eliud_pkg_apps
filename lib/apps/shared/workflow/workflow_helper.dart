import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_membership/tasks/approve_membership_task_model.dart';
import 'package:eliud_pkg_membership/tasks/request_membership_task_model.dart';
import 'package:eliud_pkg_pay/tasks/context_amount_pay_model.dart';
import 'package:eliud_pkg_pay/tasks/fixed_amount_pay_model.dart';
import 'package:eliud_pkg_pay/tasks/pay_type_types/creditcard_pay_type_model.dart';
import 'package:eliud_pkg_pay/tasks/pay_type_types/manual_pay_type_model.dart';
import 'package:eliud_pkg_pay/tasks/pay_type_types/pay_type_model.dart';
import 'package:eliud_pkg_pay/tasks/review_and_ship_task_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_notification_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_task_model.dart';

class WorkflowHelper {
  static WorkflowModel _workflowForPaymentCart(
      String appId, String documentID, String name, PayTypeModel payTypeModel) {
    return WorkflowModel(
        appId: appId,
        documentID: "cart_paid_manually",
        name: "Manual Cart Payment",
        workflowTask: [
          WorkflowTaskModel(
            seqNumber: 1,
            documentID: "workflow_task_payment",
            responsible: WorkflowTaskResponsible.currentMember,
            task: ContextAmountPayModel(
              identifier: newRandomKey(),
              executeInstantly: false,
              description: 'Please pay for your buy',
              paymentType: payTypeModel,
            ),
          ),
          WorkflowTaskModel(
            seqNumber: 2,
            documentID: "review_payment_and_ship",
            responsible: WorkflowTaskResponsible.owner,
            confirmMessage: WorkflowNotificationModel(
                message:
                    "Your payment has been reviewed and approved and your order is being prepared for shipment. Feedback from the shop: ",
                addressee: WorkflowNotificationAddressee.currentMember),
            rejectMessage: WorkflowNotificationModel(
                message:
                    "Your payment has been reviewed and rejected. Feedback from the shop: ",
                addressee: WorkflowNotificationAddressee.currentMember),
            task: ReviewAndShipTaskModel(
              identifier: newRandomKey(),
              executeInstantly: false,
              description: 'Review the payment and ship the products',
            ),
          ),
        ]);
  }

  static WorkflowModel workflowForManualPaymentCart(
      {required String appId,
      required String payTo,
      required String country,
      required String bankIdentifierCode,
      required String payeeIBAN,
      required String bankName}) {
    return _workflowForPaymentCart(
        appId,
        "cat_paid_manually",
        "Manual Cart Payment",
        ManualPayTypeModel(
            payTo: payTo,
            country: country,
            bankIdentifierCode: bankIdentifierCode,
            payeeIBAN: payeeIBAN,
            bankName: bankName));
  }

  static WorkflowModel workflowForCreditCardPaymentCart(String appId) {
    return _workflowForPaymentCart(appId, "cart_paid_by_card",
        "Cart Payment with Card", CreditCardPayTypeModel());
  }

  static WorkflowModel _workflowForMembership(String appId, String documentID,
      String name, double amount, String ccy, PayTypeModel payTypeModel) {
    return WorkflowModel(
        appId: appId,
        documentID: documentID,
        name: name,
        workflowTask: [
          WorkflowTaskModel(
            seqNumber: 1,
            documentID: "request_membership",
            responsible: WorkflowTaskResponsible.currentMember,
            task: RequestMembershipTaskModel(
              identifier: newRandomKey(),
              executeInstantly: false,
              description: 'Please join. It costs 20 GBP, 1 time cost',
            ),
          ),
          WorkflowTaskModel(
            seqNumber: 2,
            documentID: "pay_membership",
            responsible: WorkflowTaskResponsible.currentMember,
            confirmMessage: WorkflowNotificationModel(
                message:
                    "Your payment and membership request is now with the owner for review. You will be notified soon",
                addressee: WorkflowNotificationAddressee.currentMember),
            rejectMessage: null,
            task: FixedAmountPayModel(
                identifier: newRandomKey(),
                executeInstantly: true,
                description: 'To join, pay 20 GBP',
                paymentType: payTypeModel,
                ccy: ccy,
                amount: amount),
          ),
          WorkflowTaskModel(
            seqNumber: 3,
            documentID: "confirm_membership",
            responsible: WorkflowTaskResponsible.owner,
            confirmMessage: WorkflowNotificationModel(
                message:
                    "You payment has been verified and you're now a member. Welcome! Feedback: ",
                addressee: WorkflowNotificationAddressee.first),
            rejectMessage: WorkflowNotificationModel(
                message:
                    "You payment has been verified and unfortunately something went wrong. Feedback: ",
                addressee: WorkflowNotificationAddressee.first),
            task: ApproveMembershipTaskModel(
              identifier: newRandomKey(),
              executeInstantly: false,
              description: 'Verify payment and confirm membership',
            ),
          ),
        ]);
  }

  static WorkflowModel workflowForManuallyPaidMembership(
      {required String appId,
      required double amount,
      required String ccy,
      required String payTo,
      required String country,
      required String bankIdentifierCode,
      required String payeeIBAN,
      required String bankName}) {
    return _workflowForMembership(
        appId,
        "membership_paid_manually",
        "Paid Membership (manually paid)",
        20,
        "GBP",
        ManualPayTypeModel(
            payTo: payTo,
            country: country,
            bankIdentifierCode: bankIdentifierCode,
            payeeIBAN: payeeIBAN,
            bankName: bankName));
  }

  static WorkflowModel workflowForMembershipPaidByCard(String appId,
      {double? amount, String? ccy}) {
    return _workflowForMembership(
        appId,
        "membership_paid_manually",
        "Paid Membership (Credit card payment)",
        20,
        "GBP",
        CreditCardPayTypeModel(requiresConfirmation: true));
  }
}
