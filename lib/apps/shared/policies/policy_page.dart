import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_etc/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_etc/model/policy_presentation_component.dart';
import 'package:eliud_pkg_etc/model/policy_presentation_model.dart';

import '../../app_section.dart';

import '../../app_base.dart';

class PolicyPage extends AppSection {
  final MemberMediumModel policy;
  final String title;

  PolicyPage({
      this.policy,
      this.title,
      InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG,
      DrawerModel drawer,
      DrawerModel endDrawer,
      MenuDefModel adminMenu})
      : super(installApp, homeMenu, pageBG, drawer, endDrawer, adminMenu);

  PolicyPresentationModel getPesentationModel(MemberMediumModel policyModel) {
    return PolicyPresentationModel(
      documentID: policy.documentID,
      appId: installApp.appId,
      description: title,
      policy: policyModel,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
          PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<PolicyPresentationModel> createPresentationComponent(MemberMediumModel policyModel) async {
    return await policyPresentationRepository(appId: installApp.appId)
        .add(getPesentationModel(policyModel));
  }

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp.appId)
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [
      BodyComponentModel(
          documentID: policy.documentID,
          componentName: AbstractPolicyPresentationComponent.componentName,
          componentId: policy.documentID)
    ];

    return PageModel(
        documentID: policy.documentID,
        appId: installApp.appId,
        title: title,
        drawer: drawer,
        endDrawer: endDrawer,
        background: pageBG,
        appBar: appBar,
        homeMenu: homeMenu,
        layout: PageLayout.ListView,
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
        ),
        bodyComponents: components);
  }

  Future<PageModel> run() async {
    await createPresentationComponent(policy);
    var appBar = await installApp.appBar(installApp.appId, adminMenu, title);
    return await _setupPage(appBar);
  }
}
