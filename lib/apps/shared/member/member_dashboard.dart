import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/member_dashboard_component.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class MemberDashboard extends AppSectionBase {
  final RgbModel backgroundColor;

  MemberDashboard(
      InstallApp installApp, this.backgroundColor)
      : super(installApp);

  static String IDENTIFIER = "member_dashboard";

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp.appId)
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractMemberDashboardComponent.componentName,
        componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        title: "Member dashboard",
        background: backgroundColor,
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON
        ),
        bodyComponents: components);
  }

  MemberDashboardModel _dashboardModel() {
    return MemberDashboardModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        description: "Members",
        conditions: ConditionsSimpleModel(
            privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<MemberDashboardModel> _setupDashboard() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .memberDashboardRepository(installApp.appId)
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
