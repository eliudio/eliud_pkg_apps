import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
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
import 'package:eliud_pkg_notifications/model/notification_dashboard_component.dart';
import 'package:eliud_pkg_notifications/model/notification_dashboard_model.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';
import 'package:eliud_pkg_workflow/model/assignment_view_component.dart';
import 'package:eliud_pkg_workflow/model/assignment_view_model.dart';
import 'package:eliud_pkg_workflow/model/workflow_component.dart';
import 'package:eliud_pkg_workflow/workflow_package.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class AssignmentViewSetup extends AppSectionBase {
  final RgbModel backgroundColor;

  AssignmentViewSetup(InstallApp installApp, Tools newAppTools, this.backgroundColor) :
        super(installApp, newAppTools);

  static String IDENTIFIER = "assignments";

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton.dialogRepository(installApp.appId).add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractAssignmentViewComponent.componentName, componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        title: "Assignments",
        background: backgroundColor,
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
            packageCondition: WorkflowPackage.CONDITION_MUST_HAVE_ASSIGNMENTS,
            conditionOverride: ConditionOverride.InclusiveForBlockedMembers // allow blocked members to see
        ),
        bodyComponents: components);
  }

  AssignmentViewModel _assignmentViewModel() {
    return AssignmentViewModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        description: "My Assignments",
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<AssignmentViewModel> _setupAssignmentView() async {
    return await AbstractRepositorySingleton.singleton.assignmentViewRepository(installApp.appId).add(_assignmentViewModel());
  }

  Future<DialogModel> run() async {
    await _setupAssignmentView();
    return await _setupDialog();
  }
}
