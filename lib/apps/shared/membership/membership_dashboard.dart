import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/profile_and_feed_to_action.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class MembershipDashboard extends AppSectionBase {
  final String? profilePageId;
  final String? feedPageId;

  MembershipDashboard(
      InstallApp? installApp, this.profilePageId, this.feedPageId)
      : super(installApp);

  static String IDENTIFIER = "membership_dashboard";

  static OpenDialog action(AppModel app) => OpenDialog(app,
      dialogID: IDENTIFIER,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequired.OwnerPrivilegeRequired, packageCondition: CorePackage.MUST_BE_LOGGED_ON));

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractMembershipDashboardComponent.componentName,
        componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: installApp!.theApp.documentID,
        title: "Membership dashboard",
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  MembershipDashboardModel _dashboardModel() {
    return MembershipDashboardModel(
      documentID: IDENTIFIER,
      appId: installApp!.theApp.documentID,
      description: "Members",
      memberActions: ProfileAndFeedToAction.getMemberActionModels(
          installApp!.theApp, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple),
    );
  }

  Future<MembershipDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .membershipDashboardRepository(installApp!.theApp.documentID)!
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
