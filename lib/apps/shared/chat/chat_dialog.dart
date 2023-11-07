import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_chat/chat_package.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

import '../../app_section.dart';

class ChatDialog extends AppSectionBase {
  ChatDialog(super.installApp);

  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String identifierReadIt = "chat_dialog_read";
  static String identifierUnreadIt = "chat_dialog_unread";

  static OpenDialog unReadAction(AppModel app) => OpenDialog(app,
      dialogID: ChatDialog.identifierUnreadIt,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
          packageCondition: ChatPackage.conditionMemberHasUnreadChat));

  static OpenDialog readAction(AppModel app) => OpenDialog(app,
      dialogID: ChatDialog.identifierReadIt,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
          packageCondition: ChatPackage.conditionMemberAllHaveBeenRead));

  static String chatId = "chat";

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
        componentId: chatId));

    return DialogModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: "Chat",
        description: "Chat",
        includeHeading: false,
        layout: DialogLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  ChatDashboardModel _chatModel() {
    return ChatDashboardModel(
      documentID: chatId,
      appId: installApp!.theApp.documentID,
      description: "Chat",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<ChatDashboardModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatDashboardRepository(installApp!.theApp.documentID)!
        .add(_chatModel());
  }

  Future<void> run() async {
    await _setupChat();
    await _setupDialog(identifierReadIt);
    await _setupDialog(identifierUnreadIt);
  }
}
