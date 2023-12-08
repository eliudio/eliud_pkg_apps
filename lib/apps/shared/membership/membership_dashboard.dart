import 'package:eliud_core/core_package.dart';
import 'package:eliud_core_main/apis/action_api/actions/open_dialog.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core_main/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/profile_and_feed_to_action.dart';
import 'package:eliud_pkg_membership_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_model.dart';

import '../../app_section.dart';

class MembershipDashboard extends AppSectionBase {
  final String? profilePageId;
  final String? feedPageId;

  MembershipDashboard(super.installApp, this.profilePageId, this.feedPageId);

  static String identifier = "membership_dashboard";

  static OpenDialog action(AppModel app) => OpenDialog(app,
      dialogID: identifier,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.ownerPrivilegeRequired,
          packageCondition: CorePackage.mustBeLoggedIn));

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
        componentId: identifier));

    return DialogModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: "Membership dashboard",
        description: "Membership dashboard",
        layout: DialogLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  MembershipDashboardModel _dashboardModel() {
    return MembershipDashboardModel(
      documentID: identifier,
      appId: installApp!.theApp.documentID,
      description: "Members",
      memberActions: AppProfileAndFeedToAction.getMemberActionModels(
          installApp!.theApp, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple),
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
