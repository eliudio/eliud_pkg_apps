import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core_main/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/profile_and_feed_to_action.dart';
import 'package:eliud_pkg_follow_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_follow_model/model/follow_requests_dashboard_component.dart';
import 'package:eliud_pkg_follow_model/model/follow_requests_dashboard_model.dart';
import 'package:eliud_pkg_follow_model/model/following_dashboard_component.dart';
import 'package:eliud_pkg_follow_model/model/following_dashboard_model.dart';
import 'package:eliud_pkg_follow_model/model/invite_dashboard_component.dart';
import 'package:eliud_pkg_follow_model/model/invite_dashboard_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';

class _FollowingDashboard extends AppSectionBase {
  final String identifier;
  final String title;
  final String description;
  final FollowingView view;
  final String? profilePageId;
  final String? feedPageId;

  _FollowingDashboard(
    this.identifier,
    this.title,
    this.description,
    this.view,
    InstallApp? installApp,
    this.profilePageId,
    this.feedPageId,
  ) : super(installApp);

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
        layout: DialogLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  FollowingDashboardModel _dashboardModel() {
    return FollowingDashboardModel(
      documentID: identifier,
      appId: installApp!.theApp.documentID,
      description: title,
      view: view,
      memberActions: AppProfileAndFeedToAction.getMemberActionModels(
          installApp!.theApp, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
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

  static String followRequestIdentifier = "follow_requests_dashboard";
  FollowRequestDashboard(super.installApp, this.profilePageId, this.feedPageId);

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
        componentId: followRequestIdentifier));

    return DialogModel(
        documentID: followRequestIdentifier,
        appId: installApp!.theApp.documentID,
        title: "Follow requests",
        description: "Follow requests",
        layout: DialogLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  FollowRequestsDashboardModel _dashboardModel() {
    return FollowRequestsDashboardModel(
      documentID: followRequestIdentifier,
      appId: installApp!.theApp.documentID,
      description: "Follow requests",
      memberActions: AppProfileAndFeedToAction.getMemberActionModels(
          installApp!.theApp, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
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

  static String inviteIdentifier = "invite_dashboard";
  InviteDashboard(super.installApp, this.profilePageId, this.feedPageId);

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
        componentId: inviteIdentifier));

    return DialogModel(
        documentID: inviteIdentifier,
        appId: installApp!.theApp.documentID,
        title: "Follow members",
        description: "Follow members",
        layout: DialogLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  InviteDashboardModel _dashboardModel() {
    return InviteDashboardModel(
      documentID: inviteIdentifier,
      appId: installApp!.theApp.documentID,
      description: "Follow members",
      memberActions: AppProfileAndFeedToAction.getMemberActionModels(
          installApp!.theApp, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
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
  FollowDashboards(super.installApp);

  static String followersIdentifier = "followers_dashboard";
  static String followingIdentifier = "following_dashboard";

  Future<DialogModel> runIt(String? profilePageId, String? feedPageId) async {
    await _FollowingDashboard(followersIdentifier, "Followers", "Followers",
            FollowingView.followers, installApp, profilePageId, feedPageId)
        .run();
    await _FollowingDashboard(followingIdentifier, "Following", "Following",
            FollowingView.following, installApp, profilePageId, feedPageId)
        .run();
    await FollowRequestDashboard(installApp, profilePageId, feedPageId).run();
    return await InviteDashboard(installApp, profilePageId, feedPageId).run();
  }
}
