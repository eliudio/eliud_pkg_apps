import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core_model/model/abstract_repository_singleton.dart'
    as modelrepo;
import 'package:eliud_core_main/model/model_export.dart';
import 'package:eliud_core_model/model/member_dashboard_component.dart';
import 'package:eliud_core_model/model/member_dashboard_model.dart';

import '../../app_section.dart';

class MemberDashboard extends AppSectionBase {
  static String updateProfileText = '''
Maintain your personal details here
''';

  static String retrieveDataText = '''
Retrieve all you account details, every single piece of information that you have shared with us will be made available to you
''';

  static String deleteDataText = """
Do you want to leave us? Do you want to delete every single detail, every potential photo, video, text, anything?
Then here's where you can do this.
However, be careful: this process cannot be undone and everything you've ever stored here will be removed permanently",
""";

  static String retrieveDataEmailSubject = """
Your request for retrieving your data...
""";

  static String deleteDataEmailSubject = """
Your request to destroy your account...
""";

  static String deleteDataEmailMessage = """
Sorry to see you go. Your account has been destroyed.
""";

  MemberDashboard(super.installApp);

  static String identifier = "member_dashboard";

  Future<DialogModel> _setupDialog() async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractMemberDashboardComponent.componentName,
        componentId: identifier));

    return DialogModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: "Member dashboard",
        description: "Member dashboard",
        layout: DialogLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  MemberDashboardModel _dashboardModel() {
    return MemberDashboardModel(
      documentID: identifier,
      appId: installApp!.theApp.documentID,
      description: "Member dashboard",
      updateProfileText: updateProfileText,
      retrieveDataText: retrieveDataText,
      deleteDataText: deleteDataText,
      retrieveDataEmailSubject: retrieveDataEmailSubject,
      deleteDataEmailSubject: deleteDataEmailSubject,
      deleteDataEmailMessage: deleteDataEmailMessage,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<MemberDashboardModel> _setupDashboard() async {
    return await modelrepo.AbstractRepositorySingleton.singleton
        .memberDashboardRepository(installApp!.theApp.documentID)!
        .add(_dashboardModel());
  }

  Future<DialogModel> run() async {
    await _setupDashboard();
    return await _setupDialog();
  }
}
