import 'package:eliud_core_main/apis/action_api/action_model.dart';
import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_main/model/display_conditions_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_fundamentals_model/model/presentation_model.dart';
import 'package:eliud_pkg_shop_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop_model/model/model_export.dart';
import 'package:eliud_pkg_shop_model/model/pay_confirmation_component.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../shared/etc/page_template.dart';
import '../../juuwle_app.dart';

class MyPayConfirmation extends PageTemplate {
  final BackgroundModel? background;
  final ShopModel? shop;

  static const String identifier = 'juuwlepayconfirmation';

  static ActionModel action(String appId) => GotoPage(JuuwleApp.app,
      pageID: MyPayConfirmation.identifier,
      conditions: DisplayConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
        packageCondition: ShopPackage.conditionCartsHasItems,
      ));

  PayConfirmationModel _payConfirmationModel() {
    return PayConfirmationModel(
      documentID: 'payconfirmation',
      appId: installApp!.theApp.documentID,
      description: pageTitle(),
      shop: shop,
      backToShopAction: GotoPage(JuuwleApp.app, pageID: Shop.identifier),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  @override
  String pageTitle() => 'Success';

  @override
  String pageDescription() => 'Success';

  @override
  String componentName() => AbstractPayConfirmationComponent.componentName;

  MyPayConfirmation({
    this.background,
    this.shop,
    super.installApp,
    super.homeMenu,
    super.drawer,
    super.endDrawer,
  }) : super(
            privilegeLevelRequired:
                PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
            packageCondition: ShopPackage.conditionCartsHasItems,
            pageId: identifier,
            presentationImageAlignment: PresentationImageAlignment.right);

  @override
  String? componentID() {
    return _payConfirmationModel().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton
        .payConfirmationRepository(JuuwleApp.juuwleAppId)!
        .add(_payConfirmationModel());
  }

  @override
  String assetLocation() =>
      'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_with_credit_card.png';
}
