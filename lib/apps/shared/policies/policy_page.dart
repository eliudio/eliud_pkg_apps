import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_pkg_etc/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_etc/model/policy_presentation_component.dart';
import 'package:eliud_pkg_etc/model/policy_presentation_model.dart';

import '../../app_base.dart';
import '../../app_section.dart';

class PolicyPage extends AppSection {
  final PublicMediumModel? policy;
  final String title;
  final String description;

  PolicyPage({
      this.policy,
      required this.title,
      required this.description,
      InstallApp? installApp,
      HomeMenuModel? homeMenu,
      DrawerModel? drawer,
      DrawerModel? endDrawer})
      : super(installApp, homeMenu, drawer, endDrawer);

  PolicyPresentationModel getPesentationModel(PublicMediumModel? policyModel) {
    return PolicyPresentationModel(
      documentID: policy!.documentID,
      appId: installApp!.theApp.documentID,
      description: title,
      policy: policyModel,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
          PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<PolicyPresentationModel> createPresentationComponent(PublicMediumModel? policyModel) async {
    return await policyPresentationRepository(appId: installApp!.theApp.documentID)!
        .add(getPesentationModel(policyModel));
  }

  Future<PageModel> _setupPage(AppBarModel appBar) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(installApp!.theApp.documentID)!
        .add(_page(appBar));
  }

  PageModel _page(AppBarModel appBar) {
    List<BodyComponentModel> components = [
      BodyComponentModel(
          documentID: policy!.documentID,
          componentName: AbstractPolicyPresentationComponent.componentName,
          componentId: policy!.documentID)
    ];

    return PageModel(
        documentID: policy!.documentID,
        appId: installApp!.theApp.documentID,
        title: title,
        description: description,
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

  Future<PageModel> run() async {
    await createPresentationComponent(policy);
    var appBar = installApp!.appBar();
    return await _setupPage(appBar);
  }
}
