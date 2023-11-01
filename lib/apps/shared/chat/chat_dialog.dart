import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_chat/chat_package.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

import '../../install_app.dart';
import '../../app_section.dart';

class ChatDialog extends AppSectionBase {
  ChatDialog(InstallApp? installApp) : super(installApp);

  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String IDENTIFIER_READ = "chat_dialog_read";
  static String IDENTIFIER_UNREAD = "chat_dialog_unread";

  static OpenDialog unReadAction(AppModel app) => OpenDialog(app,
      dialogID: ChatDialog.IDENTIFIER_UNREAD,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_HAS_UNREAD_CHAT));

  static OpenDialog readAction(AppModel app) => OpenDialog(app,
      dialogID: ChatDialog.IDENTIFIER_READ,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_ALL_HAVE_BEEN_READ));

  static String CHAT_ID = "chat";

  Future<DialogModel> _setupDialog(String identifier) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.theApp.documentID)!
        .add(_dialog(identifier));
  }

  DialogModel _dialog(String identifier) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatDashboardComponent.componentName,
        componentId: CHAT_ID));

    return DialogModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: "Chat",
        description: "Chat",
        includeHeading: false,
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  ChatDashboardModel _chatModel() {
    return ChatDashboardModel(
      documentID: CHAT_ID,
      appId: installApp!.theApp.documentID,
      description: "Chat",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<ChatDashboardModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatDashboardRepository(installApp!.theApp.documentID)!
        .add(_chatModel());
  }

  Future<void> run() async {
    await _setupChat();
    await _setupDialog(IDENTIFIER_READ);
    await _setupDialog(IDENTIFIER_UNREAD);
  }
}
