import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/chat/chat_dialog.dart';
import 'package:eliud_pkg_apps/apps/shared/chat/chat_page.dart';

import '../../app_base.dart';

class MinkeyChatPage extends ChatPage {
  MinkeyChatPage({
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          installApp: installApp,
          homeMenu: homeMenu,
          drawer: drawer,
          endDrawer: endDrawer,
        );
}
