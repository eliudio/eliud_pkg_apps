import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/link_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';

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
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  ) : super(
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  //static String identifier = "who";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "1",
      componentName: AbstractBookletComponent.componentName,
      componentId: identifier,
    ));

    return PageModel(
        documentID: identifier,
        appId: installApp!.theApp.documentID,
        title: aboutTitle(),
        description: aboutDescription(),
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  String aboutText();
  String aboutTitle();
  String aboutDescription();
  String assetLocation();

  Future<String?> _store(PlatformMediumModel platformMediumModel) async {
    return (await AbstractRepositorySingleton.singleton
            .bookletRepository(installApp!.theApp.documentID)!
            .add(_header(platformMediumModel)))
        .documentID;
  }

  Future<PlatformMediumModel> installAboutImage() async {
    return await ImageTools.uploadPlatformPhoto(
        installApp!.theApp,
        installApp!.member!,
        assetLocation(),
        PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple);
  }

  BookletModel _header(PlatformMediumModel memberMediumModel) {
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
      description: "About",
      sections: entries,
      appId: installApp!.theApp.documentID,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<void> doIt() async {
    var image = await installAboutImage();
    var appBar = installApp!.appBar();
    await _store(image);
    await _setupPage(appBar);
  }
}
