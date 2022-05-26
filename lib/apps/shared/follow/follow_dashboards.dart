import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/profile_and_feed_to_action.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_follow/model/follow_requests_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/follow_requests_dashboard_model.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_model.dart';
import 'package:eliud_pkg_follow/model/invite_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/invite_dashboard_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class _FollowingDashboard extends AppSectionBase {
  final String identifier;
  final String title;
  final String description;
  final FollowingView view;
  final String? profilePageId;
  final String? feedPageId;

  _FollowingDashboard(this.identifier, this.title, this.description, this.view,
      InstallApp? installApp, this.profilePageId, this.feedPageId, )
      : super(installApp);

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
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
        appId: installApp!.theApp.documentID,
        title: title,
        description: description,
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  FollowingDashboardModel _dashboardModel() {
    return FollowingDashboardModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        description: title,
        view: view,
        memberActions: ProfileAndFeedToAction.getMemberActionModels(installApp!.theApp, profilePageId, feedPageId),
        conditions: StorageConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<FollowingDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .followingDashboardRepository(installApp!.theApp.documentID)!
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}

class FollowRequestDashboard extends AppSectionBase {
  final String? profilePageId;
  final String? feedPageId;

  static String FOLLOW_REQUEST_IDENTIFIER = "follow_requests_dashboard";
  FollowRequestDashboard(InstallApp? installApp, this.profilePageId, this.feedPageId)
      : super(installApp);

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractFollowRequestsDashboardComponent.componentName,
        componentId: FOLLOW_REQUEST_IDENTIFIER));

    return DialogModel(
        documentID: FOLLOW_REQUEST_IDENTIFIER,
        appId: installApp!.theApp.documentID,
        title: "Follow requests",
        description: "Follow requests",
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  FollowRequestsDashboardModel _dashboardModel() {
    return FollowRequestsDashboardModel(
      documentID: FOLLOW_REQUEST_IDENTIFIER,
      appId: installApp!.theApp.documentID,
      description: "Follow requests",
      memberActions: ProfileAndFeedToAction.getMemberActionModels(installApp!.theApp, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<FollowRequestsDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .followRequestsDashboardRepository(installApp!.theApp.documentID)!
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}

class InviteDashboard extends AppSectionBase {
  final String? profilePageId;
  final String? feedPageId;

  static String INVITE_IDENTIFIER = "invite_dashboard";
  InviteDashboard(InstallApp? installApp, this.profilePageId, this.feedPageId)
      : super(installApp);

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractInviteDashboardComponent.componentName,
        componentId: INVITE_IDENTIFIER));

    return DialogModel(
        documentID: INVITE_IDENTIFIER,
        appId: installApp!.theApp.documentID,
        title: "Follow members",
        description: "Follow members",
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  InviteDashboardModel _dashboardModel() {
    return InviteDashboardModel(
      documentID: INVITE_IDENTIFIER,
      appId: installApp!.theApp.documentID,
      description: "Follow members",
      memberActions: ProfileAndFeedToAction.getMemberActionModels(installApp!.theApp, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<InviteDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .inviteDashboardRepository(installApp!.theApp.documentID)!
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}

class FollowDashboards extends AppSectionBase {
  FollowDashboards(InstallApp? installApp)
      : super(installApp);

  static String FOLLOWERS_IDENTIFIER = "followers_dashboard";
  static String FOLLOWING_IDENTIFIER = "following_dashboard";

  Future<DialogModel> runIt(String? profilePageId,  String? feedPageId) async {
    await _FollowingDashboard(FOLLOWERS_IDENTIFIER, "Followers", "Followers", FollowingView.Followers,
        installApp, profilePageId, feedPageId).run();
    await _FollowingDashboard(FOLLOWING_IDENTIFIER, "Following", "Following", FollowingView.Following,
        installApp, profilePageId, feedPageId).run();
    await FollowRequestDashboard(installApp, profilePageId, feedPageId).run();
    return await InviteDashboard(installApp, profilePageId, feedPageId).run();
  }
}

