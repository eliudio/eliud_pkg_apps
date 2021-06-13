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
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';
import 'example_posts.dart';

class Feed extends AppSection {
  Feed({InstallApp? installApp, HomeMenuModel? homeMenu, DrawerModel? drawer, DrawerModel? endDrawer, MenuDefModel? adminMenu}) : super(installApp, homeMenu, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "feed";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp!.appId)!.add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractFeedComponent.componentName, componentId: IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: IncidamusApp.INCIDAMUS_APP_ID,
        title: "Feed",
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.Level1PrivilegeRequired,
        ),
        bodyComponents: components);
  }

  static FeedModel feedModel() {
    return FeedModel(documentID: IDENTIFIER, appId: IncidamusApp.INCIDAMUS_APP_ID, description: "My Incidamus Feed",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<FeedModel> _setupFeed() async {
    return await AbstractRepositorySingleton.singleton.feedRepository(installApp!.appId)!.add(feedModel());
  }

  Future<PageModel> run(MemberModel member) async {
    await ExamplePosts(installApp!.appId).run(member, IDENTIFIER);
    var appBar = await installApp!.appBar(IDENTIFIER, adminMenu, "Welcome");
    await _setupFeed();
    return await _setupPage(appBar);
  }
}
