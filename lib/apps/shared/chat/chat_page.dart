import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_chat/chat_package.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class ChatPage extends AppSection {
  ChatPage({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer, }) : super(installApp, homeMenu, drawer, endDrawer, );

  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String IDENTIFIER_READ = "chat_page_read";
  static String IDENTIFIER_UNREAD = "chat_page_unread";

  static GotoPage unReadAction(String appId) => GotoPage(appId, pageID: IDENTIFIER_UNREAD,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_HAS_UNREAD_CHAT));

  static GotoPage readAction(String appId) => GotoPage(appId, pageID: IDENTIFIER_READ,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_ALL_HAVE_BEEN_READ));

  static String CHAT_ID = "chat";

  Future<PageModel> _setupPage(String identifier) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.appId)!
        .add(_page(identifier));
  }

  PageModel _page(String identifier) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatDashboardComponent.componentName,
        componentId: CHAT_ID));

    return PageModel(
        documentID: identifier,
        appId: installApp!.appId,
        title: "Chat",
        drawer: drawer,
        endDrawer: endDrawer,
        homeMenu: homeMenu,
        appBar: installApp!.appBar(),
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  ChatDashboardModel _chatModel() {
    return ChatDashboardModel(
      documentID: CHAT_ID,
      appId: installApp!.appId,
      description: "Chat",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<ChatDashboardModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatDashboardRepository(installApp!.appId)!
        .add(_chatModel());
  }

  Future<void> run() async {
    await _setupChat();
    await _setupPage(IDENTIFIER_READ);
    await _setupPage(IDENTIFIER_UNREAD);
  }
}
