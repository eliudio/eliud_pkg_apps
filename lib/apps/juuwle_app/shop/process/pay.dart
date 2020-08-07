import '../../../../apps/app_base.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/process/payconfirmation.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_model/model/page_model.dart';
import 'package:eliud_model/model/pay_component.dart';
import 'package:eliud_model/model/pay_model.dart';
import 'package:eliud_model/model/presentation_model.dart';
import 'package:eliud_model/model/shop_model.dart';
import 'package:eliud_model/shared/abstract_repository_singleton.dart';
import 'package:eliud_model/shared/action_model.dart';
import 'package:eliud_model/shared/background_model.dart';

import '../../../shared/etc/page_template.dart';

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
        succeeded: GotoPage(pageID: MyPayConfirmation.identifier),
    );
  }

  @override
  String pageTitle() => 'Payment';

  @override
  String pageImageUrl() => 'https://live.staticflickr.com/65535/50087844111_19d05329c7_o_d.png';

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
      pageCondition: PageCondition.MustHaveStuffInBasket,
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
    await AbstractRepositorySingleton.singleton.payRepository().add(_payModel());
  }
}
