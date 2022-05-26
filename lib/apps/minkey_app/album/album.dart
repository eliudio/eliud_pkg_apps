import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';
import 'package:eliud_pkg_medium/model/album_repository.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_medium/model/album_component.dart';
import 'package:eliud_pkg_medium/model/album_repository.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';
import 'example_post.dart';

class Album extends AppSection {
  Album({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer, }) : super(installApp, homeMenu, drawer, endDrawer, );

  static String IDENTIFIER = "album";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp!.theApp.documentID)!.add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractAlbumComponent.componentName, componentId: IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: MinkeyApp.MINKEY_APP_ID,
        title: "Album",
        description: "Album",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.Level1PrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  Future<AlbumModel> albumModel(String memberId) async {
    var entries = await ExampleAlbumHelper(memberId: memberId).createAll();
    return AlbumModel(documentID: IDENTIFIER, appId: MinkeyApp.MINKEY_APP_ID, albumEntries: entries, description: "My Minkey Photos",
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<AlbumModel> _setupAlbum(String memberId) async {
    return await albumRepository(appId: installApp!.theApp.documentID)!.add(await albumModel(memberId));
  }

  Future<PageModel> run(MemberModel member) async {
    var appBar = installApp!.appBar();
    await _setupAlbum(member.documentID);
    return await _setupPage(appBar);
  }
}
