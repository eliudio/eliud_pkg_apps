import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/incidamus_app.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/album_component.dart';
import 'package:eliud_pkg_feed/model/album_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';
import 'example_post.dart';

class Album extends AppSection {
  Album({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer}) : super(installApp, homeMenu, drawer, endDrawer);

  static String IDENTIFIER = "album";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp!.appId)!.add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractAlbumComponent.componentName, componentId: IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: IncidamusApp.INCIDAMUS_APP_ID,
        title: "Album",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  static AlbumModel albumModel(PostModel postModel) {
    return AlbumModel(documentID: IDENTIFIER, appId: IncidamusApp.INCIDAMUS_APP_ID, post: postModel, description: "My Incidamus Photos",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<AlbumModel> _setupAlbum(PostModel postModel) async {
    return await AbstractRepositorySingleton.singleton.albumRepository(installApp!.appId)!.add(albumModel(postModel));
  }

  Future<PageModel> run(MemberModel member) async {
    PostModel photoAlbum = await ExamplePost(installApp!.appId).photoAlbum(member);
//    PostModel videoAlbum = await ExamplePost(newAppTools, installApp.appId).videoAlbum(member);
    var appBar = installApp!.appBar();
    await _setupAlbum(photoAlbum);
    return await _setupPage(appBar);
  }
}
