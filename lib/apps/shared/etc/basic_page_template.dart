import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_component.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';

abstract class BasicPageTemplate extends AppSection {
  final String pageId;
  final ReadCondition pageCondition;
  final int privilegeLevelRequired;
  final String packageCondition;

  PresentationImageAlignment presentationImageAlignment;

  String pageTitle();

  String componentID();
  String componentName();
  Future<void> setupComponent();

  BasicPageTemplate({this.pageId, this.pageCondition, this.privilegeLevelRequired, this.packageCondition, this.presentationImageAlignment, InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer,
            adminMenu);

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: pageId,
        componentId: componentID(),
        componentName: componentName()));

    return PageModel(
        documentID: pageId,
        appId: installApp.appId,
        title: pageTitle(),
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        readCondition: pageCondition,
        privilegeLevelRequired: privilegeLevelRequired,
        packageCondition: packageCondition,
        bodyComponents: components);
  }

  Future<PageModel>  run() async {
    await setupComponent();
    var appBar = await installApp.appBar(pageId, adminMenu, "Member Area");
    return await _setupPage(appBar);
  }
}
