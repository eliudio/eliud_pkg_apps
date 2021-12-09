import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

abstract class BasicPageTemplate extends AppSection {
  final String? pageId;
  final PrivilegeLevelRequiredSimple? privilegeLevelRequired;
/*
  final String? packageCondition;
  final ConditionOverride? conditionOverride;
*/

  PresentationImageAlignment? presentationImageAlignment;

  String pageTitle();

  String? componentID();
  String componentName();
  Future<void> setupComponent();

  BasicPageTemplate({this.pageId, this.privilegeLevelRequired, /*this.packageCondition, this.conditionOverride, */this.presentationImageAlignment, InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(installApp, homeMenu, drawer, endDrawer);

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.appId)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: pageId,
        componentId: componentID(),
        componentName: componentName()));

    return PageModel(
        documentID: pageId,
        appId: installApp!.appId,
        title: pageTitle(),
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: privilegeLevelRequired,
/*
          packageCondition: packageCondition,
          conditionOverride: conditionOverride
*/
        ),
        bodyComponents: components);
  }

  Future<PageModel>  run() async {
    await setupComponent();
    var appBar = installApp!.appBar();
    return await _setupPage(appBar);
  }
}
