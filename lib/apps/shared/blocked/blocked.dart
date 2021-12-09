import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_component.dart';
import 'package:eliud_pkg_fundamentals/model/booklet_model.dart';
import 'package:eliud_pkg_fundamentals/model/section_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class Blocked extends AppSection {
  Blocked({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer}) : super(installApp, homeMenu, drawer, endDrawer);

  static String identifier = "blocked";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp!.appId)!.add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractBookletComponent.componentName, componentId: blockedIdentifier));

    return PageModel(
        documentID: identifier,
        appId: installApp!.appId,
        title: "Blocked !",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  static String blockedIdentifier = "blocked";

  Future<PlatformMediumModel> uploadBlockedImage() async {
    return await ImageTools.uploadPlatformPhoto(installApp!.appId, installApp!.member!, 'packages/eliud_pkg_apps/assets/shared/blocked/blocked.png');
  }

  BookletModel _blocked(PlatformMediumModel blockedImage) {
    List<SectionModel> entries = [];
    {
      entries.add(SectionModel(
          documentID: "1",
          title: "Blocked!",
          description: "You are blocked.\n\n\nExplain...",
          image: blockedImage,
          imagePositionRelative: RelativeImagePosition.Aside,
          imageAlignment: SectionImageAlignment.Right,
          imageWidth: .33,
          links: []));
    }

    return BookletModel(
      documentID: blockedIdentifier,
      name: "Blocked!",
      sections:entries,
      appId: installApp!.appId,
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<void> _setupBlocked(PlatformMediumModel blockedImage) async {
    await AbstractRepositorySingleton.singleton.bookletRepository(installApp!.appId)!.add(_blocked(blockedImage));
  }

  Future<PageModel> run() async {
    var blockedImage = await uploadBlockedImage();
    var appBar = installApp!.appBar();
    await _setupBlocked(blockedImage);
    return await _setupPage(appBar);
  }
}
