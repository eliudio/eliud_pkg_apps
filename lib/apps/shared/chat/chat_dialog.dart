import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_chat/chat_package.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class ChatDialog extends AppSectionBase {

  ChatDialog(
      InstallApp? installApp)
      : super(installApp);

  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String IDENTIFIER_READ = "chat_dialog_read";
  static String IDENTIFIER_UNREAD = "chat_dialog_unread";

  static String CHAT_ID = "chat";

  Future<DialogModel> _setupDialog(String identifier, String packageCondition) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.appId)!
        .add(_dialog(identifier, packageCondition));
  }

  DialogModel _dialog(String identifier, String packageCondition) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatDashboardComponent.componentName,
        componentId: CHAT_ID));

    return DialogModel(
        documentID: identifier,
        appId: installApp!.appId,
        title: "Chat",
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: packageCondition
        ),
        bodyComponents: components);
  }

  ChatDashboardModel _chatModel() {
    return ChatDashboardModel(
        documentID: CHAT_ID,
        appId: installApp!.appId,
        description: "Chat",
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<ChatDashboardModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatDashboardRepository(installApp!.appId)!
        .add(_chatModel());
  }

  Future<void> run() async {
    await _setupChat();
    await _setupDialog(IDENTIFIER_READ, ChatPackage.CONDITION_MEMBER_DOES_NOT_HAVE_UNREAD_CHAT);
    await _setupDialog(IDENTIFIER_UNREAD, ChatPackage.CONDITION_MEMBER_HAS_UNREAD_CHAT);
  }
}
