import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'example_feed.dart';

class Feed extends AppSection {
  Feed({InstallApp installApp, Tools newAppTools, HomeMenuModel homeMenu, BackgroundModel pageBG, DrawerModel drawer, DrawerModel endDrawer, MenuDefModel adminMenu}) : super(installApp, newAppTools, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "feed";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp.appId).add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = List();
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractFeedComponent.componentName, componentId: IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: MinkeyApp.MINKEY_APP_ID,
        title: "Feed",
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.OwnerPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  FeedModel _feedModel() {
    return FeedModel(documentID: IDENTIFIER, appId: MinkeyApp.MINKEY_APP_ID, description: "My Minkey Feed");
  }

  Future<FeedModel> _setupFeed() async {
    return await AbstractRepositorySingleton.singleton.feedRepository(installApp.appId).add(_feedModel());
  }

  Future<PageModel> run(MemberModel member) async {
    await ExampleFeed(newAppTools).run(member);
    var appBar = await installApp.appBar(IDENTIFIER, adminMenu, "Welcome");
    await _setupFeed();
    return await _setupPage(appBar);
  }
}
