import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_model/model/page_model.dart';
import 'package:eliud_model/model/pay_component.dart';
import 'package:eliud_model/model/pay_confirmation_component.dart';
import 'package:eliud_model/model/pay_confirmation_model.dart';
import 'package:eliud_model/model/presentation_model.dart';
import 'package:eliud_model/model/shop_model.dart';
import 'package:eliud_model/shared/abstract_repository_singleton.dart';
import 'package:eliud_model/shared/action_model.dart';
import 'package:eliud_model/shared/background_model.dart';

import '../../../app_base.dart';
import '../../../shared/etc/page_template.dart';

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
        backToShopAction: GotoPage(pageID: Shop.identifier),
    );
  }

  @override
  String pageTitle() => 'Success';

  @override
  String pageImageUrl() => 'https://live.staticflickr.com/65535/50087844111_19d05329c7_o_d.png';

  @override
  String pageImageID() => 'payConfirmationImage';

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
      pageCondition: PageCondition.MustHaveStuffInBasket,
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
    await AbstractRepositorySingleton.singleton.payConfirmationRepository().add(_payConfirmationModel());
  }
}
