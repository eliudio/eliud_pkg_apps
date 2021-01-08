import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_apps/apps/app_base.dart';
import 'package:eliud_pkg_apps/apps/shared/workflow/workflow_helper.dart';
import 'package:eliud_pkg_pay/tools/task/pay_task_model.dart';
import 'package:eliud_pkg_pay/tools/task/pay_type_model.dart';
import 'package:eliud_pkg_shop/shop_package.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_task_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';
import 'package:eliud_pkg_membership/membership_package.dart';

class WorkflowSetup {
  final InstallApp installApp;

  WorkflowSetup({this.installApp});

  static double amount = 20;
  static String ccy = 'gbp';
  static String payTo = "Mr Minkey";
  static String country = "United Kingdom";
  static String bankIdentifierCode = "Bank ID Code";
  static String payeeIBAN = "IBAN 543232187632167";
  static String bankName = "Bank Of America";

  static WorkflowModel _workflowForManuallyPaidMembership() {
    return WorkflowHelper.workflowForManuallyPaidMembership(
        amount: amount,
        ccy: ccy,
        payTo: payTo,
        country: country,
        bankIdentifierCode: bankIdentifierCode,
        payeeIBAN: payeeIBAN,
        bankName: bankName
    );
  }

  static WorkflowModel _workflowForMembershipPaidByCard() {
    return WorkflowHelper.workflowForMembershipPaidByCard(
      amount: amount,
      ccy: ccy,
    );
  }

  static WorkflowModel _workflowForManualPaymentCart() {
    return WorkflowHelper.workflowForManualPaymentCart(
        payTo: payTo,
        country: country,
        bankIdentifierCode: bankIdentifierCode,
        payeeIBAN: payeeIBAN,
        bankName: bankName
    );
  }

  static WorkflowModel _workflowForCreditCardPaymentCart() {
    return WorkflowHelper.workflowForCreditCardPaymentCart(
    );
  }

  Future<void> _setupWorkflows() async {
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.appId)
        .add(_workflowForManuallyPaidMembership());
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.appId)
        .add(_workflowForMembershipPaidByCard());
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.appId)
        .add(_workflowForManualPaymentCart());
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.appId)
        .add(_workflowForCreditCardPaymentCart());
  }

  static WorkflowActionModel requestMembershipAction(String appId) =>
      WorkflowActionModel(appId,
          conditions: ConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: MembershipPackage.MEMBER_HAS_NO_MEMBERSHIP_YET,
          ),
          workflow: _workflowForManuallyPaidMembership());

  static WorkflowActionModel payCart(String appId) =>
      WorkflowActionModel(appId,
          conditions: ConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
          ),
          workflow: _workflowForCreditCardPaymentCart());

  Future<void> run() async {
    await _setupWorkflows();
  }
}
