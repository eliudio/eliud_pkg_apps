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
import 'package:eliud_pkg_fundamentals/model/photo_and_text_component.dart';
import 'package:eliud_pkg_fundamentals/model/photo_and_text_model.dart';

import '../../app_section.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../app_base.dart';

abstract class PhotoAndText extends AppSection {
  final String identifier;
  PhotoAndText(
      this.identifier,
      InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu)
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
      documentID: "1",
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
    return await newAppTools.uploadPublicPhoto(installApp.appId, installApp.member, assetLocation());
  }

  PhotoAndTextModel _photoAndText(MemberMediumModel memberMediumModel) {
    return PhotoAndTextModel(
      documentID: identifier,
      appId: installApp.appId,
      name: "About",
      title: title(),
      contents: contents(),
      image: memberMediumModel,
      imagePosition: position(),
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> doIt() async {
    var image = await installAboutImage();
    var appBar = await installApp.appBar(installApp.appId, adminMenu, title());
    await _store(image);
    await _setupPage(appBar);
  }
}
