import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/dashboard_component.dart';
import 'package:eliud_pkg_notifications/model/dashboard_model.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class Dashboard extends AppSectionBase {
  final RgbModel backgroundColor;

  Dashboard(InstallApp installApp, Tools newAppTools, this.backgroundColor) :
        super(installApp, newAppTools);

  static String IDENTIFIER = "dashboard";

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton.dialogRepository(installApp.appId).add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractDashboardComponent.componentName, componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: MinkeyApp.MINKEY_APP_ID,
        title: "Notifications",
        background: backgroundColor,
        layout: DialogLayout.ListView,
        conditional: DialogCondition.PackageDecides,
        packageCondition: NotificationsPackage.CONDITION_MEMBER_HAS_UNREAD_NOTIFICATIONS,
        bodyComponents: components);
  }

  DashboardModel _dashboardModel() {
    return DashboardModel(documentID: IDENTIFIER, appId: MinkeyApp.MINKEY_APP_ID, description: "My Minkey Notifications");
  }

  Future<DashboardModel> _setupDashboard() async {
    return await AbstractRepositorySingleton.singleton.dashboardRepository(installApp.appId).add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
