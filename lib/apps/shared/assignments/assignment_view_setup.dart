import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_workflow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_workflow/model/assignment_view_component.dart';
import 'package:eliud_pkg_workflow/model/assignment_view_model.dart';
import 'package:eliud_pkg_workflow/workflow_package.dart';

import '../../install_app.dart';
import '../../app_section.dart';

class AssignmentViewSetup extends AppSectionBase {
  AssignmentViewSetup(InstallApp? installApp) :
        super(installApp);

  static String IDENTIFIER = "assignments";

  static OpenDialog action(AppModel app) => OpenDialog(app,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: WorkflowPackage.CONDITION_MUST_HAVE_ASSIGNMENTS,
          conditionOverride: ConditionOverride.InclusiveForBlockedMembers // allow blocked members to see
      ),
      dialogID: AssignmentViewSetup.IDENTIFIER);

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton.dialogRepository(installApp!.theApp.documentID)!.add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractAssignmentViewComponent.componentName, componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: installApp!.theApp.documentID,
        title: "Assignments",
        description: "Assignments",
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
            privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
/*
            packageCondition: WorkflowPackage.CONDITION_MUST_HAVE_ASSIGNMENTS,
            conditionOverride: ConditionOverride.InclusiveForBlockedMembers // allow blocked members to see
*/
        ),
        bodyComponents: components);
  }

  AssignmentViewModel _assignmentViewModel() {
    return AssignmentViewModel(
        documentID: IDENTIFIER,
        appId: installApp!.theApp.documentID,
        description: "My Assignments",
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<AssignmentViewModel> _setupAssignmentView() async {
    return await AbstractRepositorySingleton.singleton.assignmentViewRepository(installApp!.theApp.documentID)!.add(_assignmentViewModel());
  }

  Future<DialogModel> run() async {
    await _setupAssignmentView();
    return await _setupDialog();
  }
}
