import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/pay_confirmation_component.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../app_base.dart';
import '../../../shared/etc/page_template.dart';
import '../../juuwle_app.dart';

class MyPayConfirmation extends PageTemplate {
  final BackgroundModel background;
  final ShopModel shop;

  static const String identifier = 'juuwlepayconfirmation';

  PayConfirmationModel _payConfirmationModel() {
    return PayConfirmationModel(
        documentID: 'payconfirmation',
        appId: installApp.appId,
        title: pageTitle(),
        shop: shop,
        backToShopAction: GotoPage(JuuwleApp.JUUWLE_APP_ID, pageID: Shop.identifier),
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  @override
  String pageTitle() => 'Success';

  @override
  String componentName() => AbstractPayConfirmationComponent.componentName;

  MyPayConfirmation({
    this.background,
    this.shop,
    InstallApp installApp,
    Tools newAppTools,
    HomeMenuModel homeMenu,
    BackgroundModel pageBG,
    DrawerModel drawer,
    DrawerModel endDrawer,
    MenuDefModel adminMenu}): super(
      privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
      packageCondition: ShopPackage.CONDITION_CARTS_HAS_ITEMS,
      pageId: identifier,
      installApp: installApp,
      newAppTools: newAppTools,
      homeMenu: homeMenu,
      pageBG: pageBG,
      drawer: drawer,
      endDrawer: endDrawer,
      adminMenu: adminMenu,
      presentationImageAlignment: PresentationImageAlignment.Right);

  @override
  String componentID() {
    return _payConfirmationModel().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton.payConfirmationRepository(JuuwleApp.JUUWLE_APP_ID).add(_payConfirmationModel());
  }

  @override
  String assetLocation() => 'packages/eliud_pkg_apps/assets/juuwle_app/decorating/charlotte_with_credit_card.png';
}
