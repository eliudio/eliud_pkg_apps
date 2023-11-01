import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/blocked/blocked.dart';

import '../../install_app.dart';

class MinkeyBlocked extends Blocked {
  MinkeyBlocked({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer}) :
        super(installApp: installApp, homeMenu: homeMenu, drawer: drawer,
          endDrawer: endDrawer, );
}
