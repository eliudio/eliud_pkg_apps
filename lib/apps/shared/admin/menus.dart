import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action_model.dart';

class AdminMenu {
  final String appId;

  AdminMenu(this.appId);

  MenuDefModel _adminMenu(MenuDefModel adminPopupMenu) {
    List<MenuItemModel> menuItems = List<MenuItemModel>();
    menuItems.add(MenuItemModel(
        documentID: "ADMIN",
        text: "Admin",
        description: "Admin",
        icon: IconModel(codePoint: 0xe9c6, fontFamily: "MaterialIcons"),
        action: PopupMenu(menuDef: adminPopupMenu)));
    MenuDefModel menu = MenuDefModel(
        documentID: "admin_menu",
        appId: appId,
        name: "Admin Menu",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> _storeAdminMenu(MenuDefModel adminPopupMenu) {
    return AbstractRepositorySingleton.singleton.menuDefRepository().add(_adminMenu(adminPopupMenu));
  }

  Future<MenuDefModel> run(MenuDefModel adminPopupMenu) {
    return _storeAdminMenu(adminPopupMenu);
  }
}
