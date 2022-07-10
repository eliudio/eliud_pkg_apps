import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/app_base.dart';
import 'package:eliud_pkg_apps/apps/shared/workflow/workflow_helper.dart';
import 'package:eliud_pkg_membership/membership_package.dart';
import 'package:eliud_pkg_shop/shop_package.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';

import '../../install_app.dart';
import '../minkey_app.dart';

class WorkflowSetup {
  final InstallApp installApp;

  WorkflowSetup({required this.installApp});

  static double amount = 20;
  static String ccy = 'gbp';
  static String payTo = "Mr Minkey";
  static String country = "United Kingdom";
  static String bankIdentifierCode = "Bank ID Code";
  static String payeeIBAN = "IBAN 543232187632167";
  static String bankName = "Bank Of America";

  static WorkflowModel _workflowForManuallyPaidMembership(String appId) {
    return WorkflowHelper.workflowForManuallyPaidMembership(
        appId: appId,
        amount: amount,
        ccy: ccy,
        payTo: payTo,
        country: country,
        bankIdentifierCode: bankIdentifierCode,
        payeeIBAN: payeeIBAN,
        bankName: bankName
    );
  }

  static WorkflowModel _workflowForMembershipPaidByCard(String appId) {
    return WorkflowHelper.workflowForMembershipPaidByCard(appId,
      amount: amount,
      ccy: ccy,
    );
  }

  static WorkflowModel _workflowForManualPaymentCart(String appId) {
    return WorkflowHelper.workflowForManualPaymentCart(
      appId: appId,
        payTo: payTo,
        country: country,
        bankIdentifierCode: bankIdentifierCode,
        payeeIBAN: payeeIBAN,
        bankName: bankName
    );
  }

  static WorkflowModel _workflowForCreditCardPaymentCart(String appId) {
    return WorkflowHelper.workflowForCreditCardPaymentCart(appId);
  }

  Future<void> _setupWorkflows() async {
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.theApp.documentID)!
        .add(_workflowForManuallyPaidMembership(installApp.theApp.documentID));
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.theApp.documentID)!
        .add(_workflowForMembershipPaidByCard(installApp.theApp.documentID));
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.theApp.documentID)!
        .add(_workflowForManualPaymentCart(installApp.theApp.documentID));
    await AbstractRepositorySingleton.singleton
        .workflowRepository(installApp.theApp.documentID)!
        .add(_workflowForCreditCardPaymentCart(installApp.theApp.documentID));
  }

  static WorkflowActionModel requestMembershipAction() =>
      WorkflowActionModel(MinkeyApp.app,
          conditions: DisplayConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: MembershipPackage.MEMBER_HAS_NO_MEMBERSHIP_YET,
          ),
          workflow: _workflowForManuallyPaidMembership(MinkeyApp.app.documentID));

  static WorkflowActionModel payCart() =>
      WorkflowActionModel(MinkeyApp.app,
          conditions: DisplayConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
          ),
          workflow: _workflowForCreditCardPaymentCart(MinkeyApp.app.documentID));

  Future<void> run() async {
    await _setupWorkflows();
  }
}
