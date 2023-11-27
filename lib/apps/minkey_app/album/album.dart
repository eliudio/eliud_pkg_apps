import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_medium_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium_model/model/album_component.dart';
import 'package:eliud_pkg_medium_model/model/album_model.dart';

import '../../install_app.dart';
import '../../app_section.dart';
import 'example_post.dart';

class Album extends AppSection {
  Album({
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  static String identifier = "album";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractAlbumComponent.componentName,
        componentId: identifier));

    return PageModel(
        documentID: identifier,
        appId: MinkeyApp.minkeyAppId,
        title: "Album",
        description: "Album",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.level1PrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  Future<AlbumModel> albumModel(String memberId) async {
    var entries = await ExampleAlbumHelper(memberId: memberId).createAll();
    return AlbumModel(
      documentID: identifier,
      appId: MinkeyApp.minkeyAppId,
      albumEntries: entries,
      description: "My Minkey Photos",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<AlbumModel> _setupAlbum(String memberId) async {
    return await albumRepository(appId: installApp!.theApp.documentID)!
        .add(await albumModel(memberId));
  }

  Future<PageModel> run(MemberModel member) async {
    var appBar = installApp!.appBar();
    await _setupAlbum(member.documentID);
    return await _setupPage(appBar);
  }
}
