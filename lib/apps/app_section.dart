import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'app_base.dart';

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
  final MenuDefModel? adminMenu;
  final BackgroundModel? pageBG;

  AppSection(InstallApp? installApp, this.homeMenu, this.pageBG, this.drawer, this.endDrawer, this.adminMenu):
      super(installApp);
}
