import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/notification_dashboard_component.dart';
import 'package:eliud_pkg_notifications/model/notification_dashboard_model.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class NotificationDashboard extends AppSectionBase {
  NotificationDashboard(
      InstallApp? installApp)
      : super(installApp);

  static String IDENTIFIER = "notification_dashboard";

  static OpenDialog action(AppModel app) => OpenDialog(app,
        dialogID: NotificationDashboard.IDENTIFIER,
        conditions: DisplayConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        packageCondition: NotificationsPackage.CONDITION_MEMBER_HAS_UNREAD_NOTIFICATIONS,
        conditionOverride: ConditionOverride.InclusiveForBlockedMembers // allow blocked members to see
    ));

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
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
        appId: installApp!.theApp.documentID,
        title: "Notifications",
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  NotificationDashboardModel _dashboardModel() {
    return NotificationDashboardModel(
        documentID: IDENTIFIER,
        appId: installApp!.theApp.documentID,
        description: "My Notifications",
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<NotificationDashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton
        .notificationDashboardRepository(installApp!.theApp.documentID)!
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
