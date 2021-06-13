import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/blocked/blocked.dart';

import '../../app_base.dart';

class MinkeyBlocked extends Blocked {
  MinkeyBlocked({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer, MenuDefModel? adminMenu}) :
        super(installApp: installApp, homeMenu: homeMenu, drawer: drawer,
          endDrawer: endDrawer, adminMenu: adminMenu);
}
