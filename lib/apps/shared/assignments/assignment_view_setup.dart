import 'package:eliud_core_main/apis/action_api/actions/open_dialog.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/dialog_model.dart';
import 'package:eliud_core_main/model/display_conditions_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_workflow_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow_model/model/assignment_view_component.dart';
import 'package:eliud_pkg_workflow_model/model/assignment_view_model.dart';
import 'package:eliud_pkg_workflow/workflow_package.dart';

import '../../app_section.dart';

class AssignmentViewSetup extends AppSectionBase {
  AssignmentViewSetup(super.installApp);

  static String identifier = "assignments";

  static OpenDialog action(AppModel app) => OpenDialog(app,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
          packageCondition: WorkflowPackage.conditionMustHaveAssignments,
          conditionOverride: ConditionOverride
              .inclusiveForBlockedMembers // allow blocked members to see
          ),
      dialogID: AssignmentViewSetup.identifier);

  Future<DialogModel> _setupDialog() async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractAssignmentViewComponent.componentName,
        componentId: identifier));

    return DialogModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: "Assignments",
        description: "Assignments",
        layout: DialogLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
/*
            packageCondition: WorkflowPackage.CONDITION_MUST_HAVE_ASSIGNMENTS,
            conditionOverride: ConditionOverride.InclusiveForBlockedMembers // allow blocked members to see
*/
        ),
        bodyComponents: components);
  }

  AssignmentViewModel _assignmentViewModel() {
    return AssignmentViewModel(
      documentID: identifier,
      appId: installApp!.theApp.documentID,
      description: "My Assignments",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<AssignmentViewModel> _setupAssignmentView() async {
    return await AbstractRepositorySingleton.singleton
        .assignmentViewRepository(installApp!.theApp.documentID)!
        .add(_assignmentViewModel());
  }

  Future<DialogModel> run() async {
    await _setupAssignmentView();
    return await _setupDialog();
  }
}
