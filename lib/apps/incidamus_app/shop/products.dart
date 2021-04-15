import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_pkg_apps/apps/shared/products/product.dart';
import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';
import '../../../apps/app_base.dart';
import '../incidamus_app.dart';

class Products {
  final InstallApp? installApp;
  final ShopModel shop;

  Products(
    this.installApp,
    this.shop,
  );

  static String productId1 = "black and white";
  static String productId2 = "sludge";
  static String productId3 = "govno";
  static String productId4 = "blackandwhitecar";

  Future<void> run() async {
    List<Product> theProducts = [
      // 1
      Product(
        id: productId1,
        title: "Gouldian Finch",
        about:
        "Black and white photographic collection in original quality (4000x6000). Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        assetLocation1:
        "packages/eliud_pkg_apps/assets/incidamus_app/products/blackandwhite1.webp",
        assetLocation2:
        "packages/eliud_pkg_apps/assets/incidamus_app/products/blackandwhite2.webp",
        assetLocation3:
        "packages/eliud_pkg_apps/assets/incidamus_app/products/blackandwhite3.webp",
        assetLocation4:
        "packages/eliud_pkg_apps/assets/incidamus_app/products/blackandwhite4.webp",
        price: 69.69,
      ),
      // 2
      Product(
        id: productId2,
        title: "Sludge",
        about:
        "When there is too much sludge inside. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        assetLocation1:
        "packages/eliud_pkg_apps/assets/incidamus_app/products/sludge1.webp",
        price: 35,
      ),
      // 3
      Product(
        id: productId3,
        title: "govno",
        about:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        assetLocation1:
        "packages/eliud_pkg_apps/assets/incidamus_app/products/govno1.webp",
        price: 35,
      ),
      // 4
      Product(
        id: productId4,
        title: "Black and White ar",
        about:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        assetLocation1:
        "packages/eliud_pkg_apps/assets/incidamus_app/products/blackandwhitecar1.webp",
        price: 35,
      ),
    ];

    // for now, during tests, only support 2 products
    for (int i = 0; i < theProducts.length; i++) {
      Product p = theProducts[i];
      await AbstractRepositorySingleton.singleton
          .productRepository(IncidamusApp.INCIDAMUS_APP_ID)!
          .add(await productToProductModel(shop, installApp!, p));
    }
  }
}
