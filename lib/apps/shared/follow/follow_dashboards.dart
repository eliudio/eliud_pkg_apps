import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_follow/model/follow_requests_dashboard_model.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class _FollowingDashboard extends AppSectionBase {
  final RgbModel backgroundColor;
  final String identifier;
  final String title;
  final FollowingView view;

  _FollowingDashboard(this.identifier, this.title, this.view,
      InstallApp installApp, Tools newAppTools, this.backgroundColor)
      : super(installApp, newAppTools);

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp.appId)
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractFollowingDashboardComponent.componentName,
        componentId: identifier));

    return DialogModel(
        documentID: identifier,
        appId: installApp.appId,
        title: title,
        background: backgroundColor,
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  FollowingDashboardModel _dashboardModel() {
    return FollowingDashboardModel(
        documentID: identifier,
        appId: installApp.appId,
        description: "Members",
        view: view,
        conditions: ConditionsSimpleModel(
            privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<FollowingDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .followingDashboardRepository(installApp.appId)
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}

class FollowRequestDashboard extends AppSectionBase {
  final RgbModel backgroundColor;

  static String FOLLOW_REQUEST_IDENTIFIER = "follow_requests_dashboard";
  FollowRequestDashboard(InstallApp installApp, Tools newAppTools, this.backgroundColor)
      : super(installApp, newAppTools);

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp.appId)
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractFollowingDashboardComponent.componentName,
        componentId: FOLLOW_REQUEST_IDENTIFIER));

    return DialogModel(
        documentID: FOLLOW_REQUEST_IDENTIFIER,
        appId: installApp.appId,
        title: "Follow requests",
        background: backgroundColor,
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: FollowPackage.CONDITION_MEMBER_HAS_OPEN_REQUESTS,
        ),
        bodyComponents: components);
  }

  FollowRequestsDashboardModel _dashboardModel() {
    return FollowRequestsDashboardModel(
      documentID: FOLLOW_REQUEST_IDENTIFIER,
      appId: installApp.appId,
      description: "Follow requests",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<FollowRequestsDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .followRequestsDashboardRepository(installApp.appId)
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}

class InviteDashboard extends AppSectionBase {
  final RgbModel backgroundColor;

  static String INVITE_IDENTIFIER = "invite_dashboard";
  InviteDashboard(InstallApp installApp, Tools newAppTools, this.backgroundColor)
      : super(installApp, newAppTools);

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp.appId)
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractFollowingDashboardComponent.componentName,
        componentId: INVITE_IDENTIFIER));

    return DialogModel(
        documentID: INVITE_IDENTIFIER,
        appId: installApp.appId,
        title: "Follow members",
        background: backgroundColor,
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  FollowingDashboardModel _dashboardModel() {
    return FollowingDashboardModel(
      documentID: INVITE_IDENTIFIER,
      appId: installApp.appId,
      description: "Follow requests",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<FollowingDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .followingDashboardRepository(installApp.appId)
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}

class FollowDashboards extends AppSectionBase {
  final RgbModel backgroundColor;
  FollowDashboards(InstallApp installApp, Tools newAppTools, this.backgroundColor)
      : super(installApp, newAppTools);

  static String FOLLOWERS_IDENTIFIER = "followers_dashboard";
  static String FOLLOWING_IDENTIFIER = "following_dashboard";

  Future<DialogModel> run() async {
    await _FollowingDashboard(FOLLOWERS_IDENTIFIER, "Followers", FollowingView.Followers,
        installApp, newAppTools, backgroundColor).run();
    await _FollowingDashboard(FOLLOWING_IDENTIFIER, "Following", FollowingView.Following,
        installApp, newAppTools, backgroundColor).run();
    await FollowRequestDashboard(installApp, newAppTools, backgroundColor).run();
    await InviteDashboard(installApp, newAppTools, backgroundColor).run();
  }
}

