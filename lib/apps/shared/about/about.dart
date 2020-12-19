import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/types.dart';
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

import '../../app_section.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../app_base.dart';

abstract class AboutBase extends AppSection {
  final double imageWidth;
  final RelativeImagePosition imagePosition;
  final SectionImageAlignment alignment;
  AboutBase(
      this.imagePosition,
      this.imageWidth,
      this.alignment,
      InstallApp installApp,
      Tools newAppTools,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu)
      : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer,
      adminMenu);

  static String identifier = "who";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
      documentID: "4",
      componentName: AbstractBookletComponent.componentName,
      componentId: _header().documentID,
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
        readCondition: ReadCondition.NoRestriction,
        bodyComponents: components);
  }

  String aboutText();
  String aboutTitle();
  String imageURL();

  Future<void> _store() async {
    return await AbstractRepositorySingleton.singleton
        .bookletRepository(installApp.appId)
        .add(_header());
  }

  static String aboutImageIdentifier = "charlotte";

  Future<void> installAboutImage() async {
    await newAppTools.getImgModel(
        name: aboutImageIdentifier,
        appId: installApp.appId,
        url:
        imageURL());
  }

  BookletModel _header() {
    List<SectionModel> entries = List();
    {
      List<LinkModel> links = List();
      entries.add(SectionModel(
          documentID: "1",
          title: aboutTitle(),
          description: aboutText(),
          image: newAppTools.findImageModel(aboutImageIdentifier),
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
    );
  }

  Future<void> doIt() async {
    await installAboutImage();
//    var whoMenu = await installApp.appBarMenu("Who", adminMenu);
    var appBar = await installApp.appBar(installApp.appId, adminMenu, aboutTitle());
    await _store();
    await _setupPage(appBar);
  }
}
