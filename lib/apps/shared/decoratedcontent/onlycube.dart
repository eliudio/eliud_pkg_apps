import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_album/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_album/model/model_export.dart';
import 'package:eliud_pkg_album/model/photo_cube_component.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

abstract class OnlyCube extends AppSection {
  PrivilegeLevelRequiredSimple privilegeLevelRequiredSimple;
  final String identifier;

  OnlyCube(
      this.identifier,
      InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu,
      {this.privilegeLevelRequiredSimple})
      : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  Future<PageModel> _setupPage(AppBarModel appBar, String title) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar, title));
  }

  PageModel _page(AppBarModel appBar, String title) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "content",
      componentName: AbstractPhotoCubeComponent.componentName,
      componentId: identifier,
    ));

    return PageModel(
        documentID: identifier,
        appId: installApp.appId,
        title: title,
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  Future<PhotoCubeModel> createPhotoCube(
      String appId, String title, List<PhotoCubeMediumModel> items,) async {
    var photoCubeMediumModel = PhotoCubeModel(
        documentID: identifier,
        appId: appId,
        title: title,
        description: title,
        items: items,
        conditions: ConditionsSimpleModel(
            privilegeLevelRequired: privilegeLevelRequiredSimple));
    await photoCubeRepository(appId: appId).add(photoCubeMediumModel);
    return photoCubeMediumModel;
  }

  Future<void> installCube(String title, List<PhotoCubeMediumModel> items,) async {
    var photoCube = await createPhotoCube(installApp.appId, title, items);
    var appBar = await installApp.appBar(installApp.appId, adminMenu, title);
    return await _setupPage(appBar, title);
  }
}
