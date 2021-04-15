import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_component.dart';
import 'package:eliud_pkg_fundamentals/model/decorated_content_model.dart';
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';
import '../../app_section.dart';

import '../../app_base.dart';

abstract class DecoratedContent extends AppSection {
  final String identifier;
  final bool? addLogo;
  final double percentageDecorationVisible;
  final PrivilegeLevelRequiredSimple? privilegeLevelRequiredSimple;

  PrivilegeLevelRequiredSimple? getPrivilegeLevelRequiredSimple() {
    if (privilegeLevelRequiredSimple == null) return PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple;
    return privilegeLevelRequiredSimple;
  }

  DecoratedContent(
      this.identifier,
      InstallApp? installApp,
      HomeMenuModel? homeMenu,
      BackgroundModel? pageBG,
      DrawerModel? drawer,
      DrawerModel? endDrawer,
      MenuDefModel? adminMenu, this.percentageDecorationVisible, { this.addLogo, this.privilegeLevelRequiredSimple })
      : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  Future<PageModel> _setupPage(AppBarModel appBar, String title) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.appId)!
        .add(_page(appBar, title));
  }

  Future<FaderModel> _setupFader() async {
    return await AbstractRepositorySingleton.singleton
        .faderRepository(installApp!.appId)!
        .add(_fader());
  }

  static String faderIdentifier = 'fader';
  FaderModel _fader() {
    var items = <ListedItemModel>[];
    items.add(ListedItemModel(
        documentID: 'fader',
        description: 'Fader',
        posSize: installApp!.halfScreen(),
        image: installApp!.theLogo));
    var model = FaderModel(
      documentID: faderIdentifier,
      name: 'Fader',
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: installApp!.appId,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:privilegeLevelRequiredSimple),
    );
    return model;
  }

  PageModel _page(AppBarModel appBar, String title) {
    List<BodyComponentModel> components = [];
    if ((addLogo != null) && addLogo!) {
      components.add(BodyComponentModel(
          documentID: 'fader',
          componentName: AbstractFaderComponent.componentName,
          componentId: faderIdentifier));
      components.add(BodyComponentModel(
          documentID: 'divider',
          componentName: AbstractDividerComponent.componentName,
          componentId: 'divider_1'));
    }
    components.add(BodyComponentModel(
      documentID: "content",
      componentName: AbstractDecoratedContentComponent.componentName,
      componentId: identifier,
    ));

    return PageModel(
        documentID: identifier,
        appId: installApp!.appId,
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

  Future<DecoratedContentModel> _decoratedContent(
      String? componentId,
      String componentName,
      String? decoratingComponentId,
      String decoratingComponentName,
      DecorationComponentPosition position) async {
    var decoratedContent = DecoratedContentModel(
      documentID: identifier,
      appId: installApp!.appId,
      name: identifier,
      contentComponentId: componentId,
      contentComponentName: componentName,
      decoratingComponentName: decoratingComponentName,
      decoratingComponentId: decoratingComponentId,
      percentageDecorationVisible: percentageDecorationVisible,
      decorationComponentPosition: position,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: getPrivilegeLevelRequiredSimple()
      ),
    );
    await AbstractRepositorySingleton.singleton
        .decoratedContentRepository(installApp!.appId)!
        .add(decoratedContent);
    return decoratedContent;
  }

  Future<void> installDecoratedContent(
      String title,
      String? componentId,
      String componentName,
      String? decoratingComponentId,
      String decoratingComponentName,
      DecorationComponentPosition position) async {
    if ((addLogo != null) && addLogo!) {
      await _setupFader();
    }
    await _decoratedContent(componentId, componentName, decoratingComponentId, decoratingComponentName, position);
    var appBar = await installApp!.appBar(installApp!.appId, adminMenu, title);
    await _setupPage(appBar, title);
  }
}
