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

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.appId)!
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
        appId: installApp!.appId,
        title: "Membership dashboard",
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.OwnerPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  MembershipDashboardModel _dashboardModel() {
    return MembershipDashboardModel(
        documentID: IDENTIFIER,
        appId: installApp!.appId,
        description: "Members",
        memberActions: ProfileAndFeedToAction.getMemberActionModels(installApp!.appId, profilePageId, feedPageId),
        conditions: ConditionsSimpleModel(
            privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<MembershipDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .membershipDashboardRepository(installApp!.appId)!
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
