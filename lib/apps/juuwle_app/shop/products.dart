import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';

import '../../../apps/app_base.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../juuwle_app.dart';

class Products {
  final InstallApp installApp;
  final Tools newAppTools;
  final ShopModel shop;

  Products(
    this.installApp,
    this.newAppTools,
    this.shop,
  );

  ProductModel product(Product product) {
    List<ProductImageModel> productImages = List();
    productImages.add(ProductImageModel(
        documentID: product.imageId1(),
        image: newAppTools.findImageModel(product.imageId1())));
    productImages.add(ProductImageModel(
        documentID: product.imageId2(),
        image: newAppTools.findImageModel(product.imageId2())));
    return new ProductModel(
        documentID: product.id,
        appId: installApp.appId,
        title: product.title,
        about: product.about,
        shop: shop,
        images: productImages,
        price: product.price,
        weight: 100,
        posSize: installApp.screen75());
  }

  static String productId1 = "gouldian_finch";
  static String productId2 = "red_breasted_blackbird";
  static String productId3 = "queen_of_the_night";
  static String productId4 = "golden_oriole";
  static String productId5 = "turquoise_kakariki";
  static String productId6 = "amaryllis";
  static String productId7 = "daisy";
  static String productId8 = "anemone";
  static String productId9 = "lily_of_the_nile";
  static String productId10 = "blue_backed_manakin";
  static String productId11 = "northern_cardinal";
  static String productId12 = "eurasian_magpie";
  static String productId13 = "myna";
  static String productId14 = "parakeet";
  static String productId15 = "kingbird";
  static String productId16 = "grosbeak";
  Future<void> run() async {
    List<Product> theProducts = [
      // 1
      Product(
        id: productId1,
        title: "Gouldian Finch",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50706772038_38659bea74_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707591592_f22d29b83e_o_d.png",
        price: 11,
      ),
      // 2
      Product(
        id: productId2,
        title: "Red Breasted Blackbird",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707591567_b0c243f130_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707591577_a5d7fa310c_o_d.png",
        price: 11,
      ),
      // 3
      Product(
        id: productId3,
        title: "Queen of the Night",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50706772433_049e9d7910_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707591557_937e58cea7_o_d.png",
        price: 11,
      ),
      // 4
      Product(
        id: productId4,
        title: "Golden Oriole",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50706772413_6a2c7c97f1_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707591542_5ef52af9fd_o_d.png",
        price: 11,
      ),
      // 5
      Product(
        id: productId5,
        title: "Turquoise Kakariki",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707591502_2f3d05731c_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707509206_07ac34e084_o_d.png",
        price: 11,
      ),
      // 6
      Product(
        id: productId6,
        title: "Amaryllis",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707509171_d1becd195a_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707509186_621019dd97_o_d.png",
        price: 11,
      ),
      // 7
      Product(
        id: productId7,
        title: "Daisy",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707591467_8f17cc2c9d_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707509166_93c7349d19_o_d.png",
        price: 11,
      ),
      // 8
      Product(
        id: productId8,
        title: "Anemone",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707509156_742bf96973_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707509161_deb43241e7_o_d.png",
        price: 11,
      ),
      // 9
      Product(
        id: productId9,
        title: "Lily Of The Nile",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707591417_465659b737_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707509151_94ef3b9884_o_d.png",
        price: 11,
      ),
      // 10
      Product(
        id: productId10,
        title: "Blue Backed Manakin",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50706772283_36fd333305_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707509101_f02a83b99d_o_d.png",
        price: 11,
      ),
      // 11
      Product(
        id: productId11,
        title: "Northern Cardinal",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707509051_d9d4870702_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50706772268_1c36f61752_o_d.png",
        price: 11,
      ),
      // 12
      Product(
        id: productId12,
        title: "Eurasian Magpie",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707509006_bb1e196c9d_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707591327_061a954efa_o_d.png",
        price: 11,
      ),
      // 13
      Product(
        id: productId13,
        title: "Myna",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707591272_d66565b4ea_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707591292_15bdfd04e6_o_d.png",
        price: 11,
      ),
      // 14
      Product(
        id: productId14,
        title: "Parakeet",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707591247_2c43f0fdf7_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50706772168_79b6413f71_o_d.png",
        price: 11,
      ),
      // 15
      Product(
        id: productId15,
        title: "Kingbird",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707591187_580b3ce8e5_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50707508906_8050d661f6_o_d.png",
        price: 11,
      ),
      // 16
      Product(
        id: productId16,
        title: "Grosbeak",
        about:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
        url1:
            "https://live.staticflickr.com/65535/50707508866_885a0c24c1_o_d.png",
        url2:
            "https://live.staticflickr.com/65535/50706772098_d2d08c8e9c_o_d.png",
        price: 11,
      )
    ];

    // for now, during tests, only support 2 products
    for (int i = 0; i < theProducts.length; i++) {
      Product p = theProducts[i];
      await newAppTools.getImgModel(
          name: p.imageId1(), appId: JuuwleApp.JUUWLE_APP_ID, url: p.url1);
      await newAppTools.getImgModel(
          name: p.imageId2(), appId: JuuwleApp.JUUWLE_APP_ID, url: p.url2);
      await AbstractRepositorySingleton.singleton
          .productRepository(JuuwleApp.JUUWLE_APP_ID)
          .add(product(p));
    }
  }
}

class Product {
  final String id;
  final String title;
  final String about;
  final String url1;
  final String url2;
  final double price;

  Product({this.id, this.title, this.about, this.url1, this.url2, this.price});

  String imageId1() => title + "a";
  String imageId2() => title + "b";
}
