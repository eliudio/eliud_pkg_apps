import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';

abstract class BasicPageTemplate extends AppSection {
  final String pageId;
  final PrivilegeLevelRequired privilegeLevelRequired;
  final String packageCondition;
  final ConditionOverride conditionOverride;

  PresentationImageAlignment presentationImageAlignment;

  String pageTitle();

  String componentID();
  String componentName();
  Future<void> setupComponent();

  BasicPageTemplate({this.pageId, this.privilegeLevelRequired, this.packageCondition, this.conditionOverride, this.presentationImageAlignment, InstallApp installApp,
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
        conditions: ConditionsModel(
          privilegeLevelRequired: privilegeLevelRequired,
          packageCondition: packageCondition,
          conditionOverride: conditionOverride
        ),
        bodyComponents: components);
  }

  Future<PageModel>  run() async {
    await setupComponent();
    var appBar = await installApp.appBar(pageId, adminMenu, "Member Area");
    return await _setupPage(appBar);
  }
}
