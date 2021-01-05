import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class MembershipDashboard extends AppSectionBase {
  final RgbModel backgroundColor;

  MembershipDashboard(InstallApp installApp, Tools newAppTools, this.backgroundColor) :
        super(installApp, newAppTools);

  static String IDENTIFIER = "membership_dashboard";

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton.dialogRepository(installApp.appId).add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractMembershipDashboardComponent.componentName, componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        title: "Membership dashboard",
        background: backgroundColor,
        layout: DialogLayout.ListView,
        readCondition: ReadCondition.MemberOrPrivilegedMemberOnly,
        privilegeLevelRequired: OWNER_PRIVILEGES,
        bodyComponents: components);
  }

  MembershipDashboardModel _dashboardModel() {
    return MembershipDashboardModel(documentID: IDENTIFIER, appId: installApp.appId, description: "Members");
  }

  Future<MembershipDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton.membershipDashboardRepository(installApp.appId).add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
