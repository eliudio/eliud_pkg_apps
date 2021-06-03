import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/feed/profile_component.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'example_posts.dart';
import 'example_profile.dart';
import 'feed_menu.dart';
import 'header_component.dart';

class Feed extends AppSection {
  Feed({InstallApp? installApp, HomeMenuModel? homeMenu, BackgroundModel? pageBG, DrawerModel? drawer, DrawerModel? endDrawer, MenuDefModel? adminMenu}) : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "feed";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton.pageRepository(installApp!.appId)!.add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractFeedMenuComponent.componentName, componentId: FeedMenu.FEED_MENU_ID));
    components.add(BodyComponentModel(
        documentID: "2", componentName: AbstractHeaderComponent.componentName, componentId: HeaderComponent.HEADER_ID));
    components.add(BodyComponentModel(
        documentID: "3", componentName: AbstractFeedComponent.componentName, componentId: IDENTIFIER));

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
          privilegeLevelRequired: PrivilegeLevelRequired.Level1PrivilegeRequired,
        ),
        bodyComponents: components);
  }

  static FeedModel feedModel() {
    return FeedModel(documentID: IDENTIFIER, appId: MinkeyApp.MINKEY_APP_ID, description: "My Minkey Feed",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<FeedModel> _setupFeed() async {
    return await AbstractRepositorySingleton.singleton.feedRepository(installApp!.appId)!.add(feedModel());
  }

  Future<PageModel> run(MemberModel member) async {
    // common for all pages:
    var readAccess = await  PostFollowersMemberHelper.asPublic(installApp!.appId!, member.documentID!);
    await ExamplePosts(installApp!.appId, readAccess).run(member, IDENTIFIER);
    await ExampleProfile(installApp!.appId, readAccess).run(member, IDENTIFIER);
    await FeedMenu(installApp!.appId!).run();
    await ProfileComponent(installApp!.appId!).run();
    await HeaderComponent(installApp!.appId!).run();

    // Specific to feed page
    var appBar = await installApp!.appBar(IDENTIFIER, adminMenu, "Feed");
    await _setupFeed();
    return await _setupPage(appBar);
  }
}
