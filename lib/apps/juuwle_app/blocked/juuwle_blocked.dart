import 'package:eliud_pkg_apps/apps/shared/blocked/blocked.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_base.dart';

class JuuwleBlocked extends Blocked {
  JuuwleBlocked({InstallApp? installApp, HomeMenuModel? homeMenu, BackgroundModel? pageBG, DrawerModel? drawer, DrawerModel? endDrawer, MenuDefModel? adminMenu}) :
        super(installApp: installApp, homeMenu: homeMenu, pageBG: pageBG, drawer: drawer,
          endDrawer: endDrawer, adminMenu: adminMenu);
}
