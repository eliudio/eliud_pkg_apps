import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/notification_dashboard_component.dart';
import 'package:eliud_pkg_notifications/model/notification_dashboard_model.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class NotificationDashboard extends AppSectionBase {
  final RgbModel backgroundColor;

  NotificationDashboard(
      InstallApp installApp, Tools newAppTools, this.backgroundColor)
      : super(installApp, newAppTools);

  static String IDENTIFIER = "notification_dashboard";

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp.appId)
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractNotificationDashboardComponent.componentName,
        componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        title: "Notifications",
        background: backgroundColor,
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition:
              NotificationsPackage.CONDITION_MEMBER_HAS_UNREAD_NOTIFICATIONS,
          conditionOverride: ConditionOverride.InclusiveForBlockedMembers // allow blocked members to see
        ),
        bodyComponents: components);
  }

  NotificationDashboardModel _dashboardModel() {
    return NotificationDashboardModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        description: "My Notifications");
  }

  Future<NotificationDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .notificationDashboardRepository(installApp.appId)
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
