import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/extensions/member_profile_component.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_section.dart';
import '../../app_base.dart';

class MemberPage extends AppSection {
  MemberPage(
      InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu)
      : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  static String IDENTIFIER = "member_profile";

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: MemberProfileConstructorDefault
            .MEMBER_PROFILE_COMPONENT_IDENTIFIER));

    return PageModel(
        documentID: IDENTIFIER,
        appId: installApp.appId,
        title: "Member Profile",
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.OnlyTheFirstComponent,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  // ************************ Tutorials *****************
  Future<PageModel> run() async {
//    var menu = await installApp.appBarMenu("Your Profile", adminMenu);
    var appBar = await installApp.appBar(IDENTIFIER, adminMenu, "Member Area");
    return await _setupPage(appBar);
  }
}
