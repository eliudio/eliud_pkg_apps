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

class ChatPage extends AppSection {
  ChatPage({
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String identifierReadIt = "chat_page_read";
  static String identifierUnreadIt = "chat_page_unread";

  static GotoPage unReadAction(AppModel app) => GotoPage(app,
      pageID: identifierUnreadIt,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
          packageCondition: ChatPackage.conditionMemberHasUnreadChat));

  static GotoPage readAction(AppModel app) => GotoPage(app,
      pageID: identifierReadIt,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
          packageCondition: ChatPackage.conditionMemberAllHaveBeenRead));

  static String chatId = "chat";

  Future<PageModel> _setupPage(String identifier) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(identifier));
  }

  PageModel _page(String identifier) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatDashboardComponent.componentName,
        componentId: chatId));

    return PageModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: "Chat",
        description: "Chat",
        drawer: drawer,
        endDrawer: endDrawer,
        homeMenu: homeMenu,
        appBar: installApp!.appBar(),
        layout: PageLayout.listView,
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
    await _setupPage(identifierReadIt);
    await _setupPage(identifierUnreadIt);
  }
}
