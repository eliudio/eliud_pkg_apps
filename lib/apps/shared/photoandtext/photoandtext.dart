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
import 'package:eliud_pkg_fundamentals/model/divider_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_component.dart';
import 'package:eliud_pkg_fundamentals/model/fader_model.dart';
import 'package:eliud_pkg_fundamentals/model/listed_item_model.dart';
import 'package:eliud_pkg_fundamentals/model/photo_and_text_component.dart';
import 'package:eliud_pkg_fundamentals/model/photo_and_text_model.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import '../../app_section.dart';

import '../../app_base.dart';

abstract class PhotoAndText extends AppSection {
  final String identifier;
  final bool addLogo;
  final double percentageImageVisible;
  PhotoAndText(
      this.identifier,
      InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu, this.percentageImageVisible, { this.addLogo })
      : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar));
  }

  Future<void> _setupFader() async {
    return await AbstractRepositorySingleton.singleton
        .faderRepository(installApp.appId)
        .add(_fader());
  }

  static String faderIdentifier = 'fader';
  FaderModel _fader() {
    var items = <ListedItemModel>[];
    items.add(ListedItemModel(
        documentID: 'fader',
        description: 'Fader',
        posSize: installApp.halfScreen(),
        image: installApp.theLogo));
    var model = FaderModel(
      documentID: faderIdentifier,
      name: 'Fader',
      animationMilliseconds: 1000,
      imageSeconds: 5,
      items: items,
      appId: installApp.appId,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
          PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
    return model;
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    if ((addLogo != null) && (addLogo)) {
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
      documentID: "welcome",
      componentName: AbstractPhotoAndTextComponent.componentName,
      componentId: identifier,
    ));

    return PageModel(
        documentID: identifier,
        appId: installApp.appId,
        title: title(),
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

  String contents();
  String title();
  String assetLocation();
  PhotoAndTextImagePosition position();

  Future<String> _store(MemberMediumModel memberMediumModel) async {
    return (await AbstractRepositorySingleton.singleton
        .photoAndTextRepository(installApp.appId)
        .add(_photoAndText(memberMediumModel))).documentID;
  }

  Future<MemberMediumModel> installAboutImage() async {
    return await ImageTools.uploadPublicPhoto(installApp.appId, installApp.member, assetLocation());
  }

  PhotoAndTextModel _photoAndText(MemberMediumModel memberMediumModel) {
    return PhotoAndTextModel(
      documentID: identifier,
      appId: installApp.appId,
      name: "About",
      title: title(),
      contents: contents(),
      image: memberMediumModel,
      percentageImageVisible: percentageImageVisible,
      imagePosition: position(),
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> doIt() async {
    if ((addLogo != null) && (addLogo)) {
      await _setupFader();
    }
    var image = await installAboutImage();
    var appBar = await installApp.appBar(installApp.appId, adminMenu, title());
    await _store(image);
    await _setupPage(appBar);
  }
}
