import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/model/policy_model.dart';
import 'package:eliud_core/model/policy_presentation_component.dart';
import 'package:eliud_core/model/policy_presentation_model.dart';
import 'package:eliud_pkg_apps/apps/tools/policy_tools.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import '../../app_section.dart';

import '../../app_base.dart';

class PolicyPageAndModel extends AppSection {
  final String id;
  final String title;
  final String policyAssetLocation;

  PolicyPageAndModel({
      this.id,
      this.title,
      this.policyAssetLocation,
      InstallApp installApp,
      HomeMenuModel homeMenu,
      BackgroundModel pageBG})
      : super(installApp, homeMenu, pageBG, null, null,
      null);

  PolicyPresentationModel getPesentationModel(PolicyModel policyModel) {
    return PolicyPresentationModel(
      documentID: id,
      appId: installApp.appId,
      description: id,
      policy: policyModel,
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired:
          PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<PolicyPresentationModel> createPresentationComponent(PolicyModel policyModel) async {
    return await corerepo
        .policyPresentationRepository(appId: installApp.appId)
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
          documentID: id,
          componentName: AbstractPolicyPresentationComponent.componentName,
          componentId: id)
    ];

    return PageModel(
        documentID: id,
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

  Future<PolicyModel> run() async {
    var policy = await PolicyTools.getPolicyFromHtml(
        installApp.appId, id, policyAssetLocation);
    await createPresentationComponent(policy);
    var appBar = await installApp.appBar(installApp.appId, adminMenu, title);
    await _setupPage(appBar);
    return policy;
  }
}
