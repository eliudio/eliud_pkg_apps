import 'package:eliud_core/model/admin_app.dart' as coreadmin;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_fundamentals/model/admin_app.dart' as fundamentals;

import '../../install_app.dart';

class Admin extends AdminBase {
  Admin(
      {InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(installApp, homeMenu, drawer, endDrawer);

  @override
  String adminTitle() => "Admin";

  @override
  List<AdminAppInstallerBase> adminAppsInstallers(String? appID, DrawerModel? drawer, DrawerModel_endDrawer, AppBarModel appBar, HomeMenuModel? homeMenu) {
    return [
      coreadmin.AdminApp(appID!, drawer!, endDrawer!, appBar, homeMenu!, EliudColors.white, EliudColors.blackTransparent, EliudColors.gray),
      fundamentals.AdminApp(appID, drawer, endDrawer!, appBar, homeMenu, EliudColors.white, EliudColors.blackTransparent, EliudColors.gray),
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




