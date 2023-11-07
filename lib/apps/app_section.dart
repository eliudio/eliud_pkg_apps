import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import 'install_app.dart';

// Required for dialog
class AppSectionBase {
  final InstallApp? installApp;
  AppSectionBase(this.installApp);
}

// Required for page
class AppSection extends AppSectionBase {
  final HomeMenuModel? homeMenu;
  final DrawerModel? drawer;
  final DrawerModel? endDrawer;

  AppSection(super.installApp, this.homeMenu, this.drawer, this.endDrawer);
}
