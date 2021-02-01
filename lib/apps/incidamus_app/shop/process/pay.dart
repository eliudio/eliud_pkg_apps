import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/workflow/workflow_setup.dart';
import 'package:eliud_pkg_fundamentals/model/presentation_model.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import 'package:eliud_pkg_shop/model/pay_component.dart';
import 'package:eliud_pkg_shop/shop_package.dart';

import '../../../../apps/app_base.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';

import '../../../shared/etc/page_template.dart';
import '../../incidamus_app.dart';

class MyPay extends PageTemplate {
  final BackgroundModel background;
  final ShopModel shop;

  static const String identifier = 'juuwlepay';

  PayModel _payModel() {
    return PayModel(
        documentID: 'pay',
        appId: installApp.appId,
        title: pageTitle(),
        shop: shop,
        payAction: WorkflowSetup.payCart(installApp.appId),
        succeeded: GotoPage(IncidamusApp.INCIDAMUS_APP_ID, pageID: MyPayConfirmation.identifier),
        conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
        ),
    );
  }

  @override
  String pageTitle() => 'Payment';

  @override
  String pageImageUrl() => 'https://live.staticflickr.com/65535/50707454221_da890ba31b_o_d.png';

  @override
  String pageImageID() => 'payImage';

  @override
  String componentName() => AbstractPayComponent.componentName;

  MyPay({
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
      presentationImageAlignment: PresentationImageAlignment.Left);

  @override
  String componentID() {
    return _payModel().documentID;
  }

  @override
  Future<void> setupComponent() async {
    await AbstractRepositorySingleton.singleton.payRepository(IncidamusApp.INCIDAMUS_APP_ID).add(_payModel());
  }
}