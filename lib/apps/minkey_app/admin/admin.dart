import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_base.dart';

class Admin extends AdminBase {
  Admin(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      BackgroundModel? pageBG,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(installApp, homeMenu, pageBG, drawer, endDrawer);

  @override
  String adminTitle() => "Admin";

  @override
  List<AdminAppInstallerBase> adminAppsInstallers(String? appID, DrawerModel? drawer, DrawerModel_endDrawer, AppBarModel appBar, HomeMenuModel? homeMenu) {
    return [
      coreadmin.AdminApp(appID!, drawer!, endDrawer!, appBar, homeMenu!, EliudColors.black, EliudColors.green, EliudColors.lightRed),
      fundamentals.AdminApp(appID, drawer, endDrawer!, appBar, homeMenu, EliudColors.black, EliudColors.green, EliudColors.lightRed),
    ];
  }

  @override
  List<AdminAppMenuInstallerBase> adminMenuInstallers() {
    return [
      coreadmin.AdminMenu(),
      fundamentals.AdminMenu(),
    ];
  }
}
