import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/shared/blocked/blocked.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';

class JuuwleBlocked extends Blocked {
  JuuwleBlocked({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) :
        super(installApp: installApp, newAppTools: newAppTools, homeMenu: homeMenu, pageBG: pageBG, drawer: drawer,
          endDrawer: endDrawer, adminMenu: adminMenu);
}
