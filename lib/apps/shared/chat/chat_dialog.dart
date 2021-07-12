import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_chat/model/chat_component.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class ChatDialog extends AppSectionBase {

  ChatDialog(
      InstallApp? installApp)
      : super(installApp);

  static String IDENTIFIER = "chat_dialog";

  Future<DialogModel> _setupDialog() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(installApp!.appId)!
        .add(_dialog());
  }

  DialogModel _dialog() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatComponent.componentName,
        componentId: IDENTIFIER));

    return DialogModel(
        documentID: IDENTIFIER,
        appId: installApp!.appId,
        title: "Chat",
        layout: DialogLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  ChatModel _chatModel() {
    return ChatModel(
        documentID: IDENTIFIER,
        appId: installApp!.appId,
        description: "Chat",
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  Future<ChatModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatRepository(installApp!.appId)!
        .add(_chatModel());
  }

  Future<DialogModel> run() async {
    await _setupChat();
    return await _setupDialog();
  }
}
