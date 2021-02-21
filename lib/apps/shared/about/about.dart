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
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/link_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';

import '../../app_section.dart';

import '../../app_base.dart';

abstract class AboutBase extends AppSection {
  final String identifier;
  final double imageWidth;
  final RelativeImagePosition imagePosition;
  final SectionImageAlignment alignment;
  AboutBase(
      this.identifier,
      this.imagePosition,
      this.imageWidth,
      this.alignment,
      InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu)
      : super(installApp, homeMenu, pageBG, drawer, endDrawer,
      adminMenu);

  //static String identifier = "who";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
      documentID: "1",
      componentName: AbstractBookletComponent.componentName,
      componentId: identifier,
    ));

    return PageModel(
        documentID: identifier,
        appId: installApp.appId,
        title: aboutTitle(),
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

  String aboutText();
  String aboutTitle();
  String assetLocation();

  Future<String> _store(MemberMediumModel memberMediumModel) async {
    return (await AbstractRepositorySingleton.singleton
        .bookletRepository(installApp.appId)
        .add(_header(memberMediumModel))).documentID;
  }

  Future<MemberMediumModel> installAboutImage() async {
    return await ImageTools.uploadPublicPhoto(installApp.appId, installApp.member, assetLocation());
  }

  BookletModel _header(MemberMediumModel memberMediumModel) {
    List<SectionModel> entries = [];
    {
      List<LinkModel> links = [];
      entries.add(SectionModel(
          documentID: "1",
          title: aboutTitle(),
          description: aboutText(),
          image: memberMediumModel,
          imagePositionRelative: imagePosition,
          imageAlignment: alignment,
          imageWidth: imageWidth,
          links: links));
    }

    return BookletModel(
      documentID: identifier,
      name: "About",
      sections: entries,
      appId: installApp.appId,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> doIt() async {
    var image = await installAboutImage();
    var appBar = await installApp.appBar(installApp.appId, adminMenu, aboutTitle());
    await _store(image);
    await _setupPage(appBar);
  }
}
