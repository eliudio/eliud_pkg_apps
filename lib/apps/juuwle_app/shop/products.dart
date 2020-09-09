import 'package:eliud_pkg_shop/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_shop/model/model_export.dart';

import '../../../apps/app_base.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../juuwle_app.dart';


class Products {
  final InstallApp installApp;
  final Tools newAppTools;
  final ShopModel shop;

  Products(this.installApp, this.newAppTools, this.shop,);

  ProductModel product(Product product) {
    List<ProductImageModel> productImages = List();
    productImages.add(ProductImageModel(documentID: product.imageId1(), image: newAppTools.findImageModel(product.imageId1())));
    productImages.add(ProductImageModel(documentID: product.imageId2(), image: newAppTools.findImageModel(product.imageId2())));
    return new ProductModel(
      documentID: product.title,
      appId: installApp.appId,
      title: product.title,
      about: product.about,
      shop: shop,
      images: productImages,
      price: product.price,
      weight: 100,
      posSize: installApp.screen75()
    );
  }

  Future<void> run() async {
    List<Product> theProducts = [
    // 1
    Product(
      id: "gouldian_finch",
      title: "Gouldian Finch",
      about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
      url1: "https://live.staticflickr.com/65535/50002663161_01c12aea71_o_d.png",
      url2: "https://live.staticflickr.com/65535/50002664321_4640d329a6_o_d.png",
      price: 11,
    ),
    // 2
    Product(
    id: "red_breasted_blackbird",
    title: "Red Breasted Blackbird",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002144203_ee0f008d3a_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002920472_f3193047ca_o_d.png",
    price: 11,
    ),
    // 3
    Product(
    id: "queen_of_the_night",
    title: "Queen of the Night",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002920422_2f1c01b6f8_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002144118_c69bcde830_o_d.png",
    price: 11,
    ),
    // 4
    Product(
    id: "golden_oriole",
    title: "Golden Oriole",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002144073_957d36b97d_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002664126_7dc5a68f65_o_d.png",
    price: 11,
    ),
    // 5
    Product(
    id: "turquoise_kakariki",
    title: "Turquoise Kakariki",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002664106_c54e3c3415_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002920262_1ce93cef78_o_d.png",
    price: 11,
    ),
    // 6
    Product(
    id: "amaryllis",
    title: "Amaryllis",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002664066_db160ff2e4_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002920177_2782a1535b_o_d.png",
    price: 11,
    ),
    // 7
    Product(
    id: "daisy",
    title: "Daisy",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002920147_24be00455a_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002663941_012125e5bc_o_d.png",
    price: 11,
    ),
    // 8
    Product(
    id: "anemone",
    title: "Anemone",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002920037_7335b8f3c2_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002663871_ebcac39aa1_o_d.png",
    price: 11,
    ),
    // 9
    Product(
    id: "lily_of_the_nile",
    title: "Lily Of The Nile",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002919932_689640ce93_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002919892_f3dd820cf2_o_d.png",
    price: 11,
    ),
    // 10
    Product(
    id: "blue_backed_manakin",
    title: "Blue Backed Manakin",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002663771_ace6a50dde_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002143523_ca121bb14a_o_d.png",
    price: 11,
    ),
    // 11
    Product(
    id: "northern_cardinal",
    title: "Northern Cardinal",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002143498_b4cb7ea475_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002143458_a49c4bb912_o_d.png",
    price: 11,
    ),
    // 12
    Product(
    id: "eurasian_magpie",
    title: "Eurasian Magpie",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002143388_4b439b5ac5_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002919617_1dc1123848_o_d.png",
    price: 11,
    ),
    // 13
    Product(
    id: "myna",
    title: "Myna",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002143323_ac525ea6af_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002663421_6e82d00014_o_d.png",
    price: 11,
    ),
    // 14
    Product(
    id: "parakeet",
    title: "Parakeet",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002143248_67d00d4b95_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002919472_04b0664203_o_d.png",
    price: 11,
    ),
    // 15
    Product(
    id: "kingbird",
    title: "Kingbird",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002143138_afebe3052f_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002919412_560ce60e7b_o_d.png",
    price: 11,
    ),
    // 16
    Product(
    id: "grosbeak",
    title: "Grosbeak",
    about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
    url1: "https://live.staticflickr.com/65535/50002919387_457a777e0e_o_d.png",
    url2: "https://live.staticflickr.com/65535/50002143003_ae19ac6870_o_d.png",
    price: 11,
    )
    ];
    
    // for now, during tests, only support 2 products
    for (int i = 0; i < theProducts.length; i++) {
      Product p = theProducts[i];
      await newAppTools.getImgModel(name: p.imageId1(), appId: JuuwleApp.JUUWLE_APP_ID, url: p.url1);
      await newAppTools.getImgModel(name: p.imageId2(), appId: JuuwleApp.JUUWLE_APP_ID, url: p.url2);
      await AbstractRepositorySingleton.singleton.productRepository().add(product(p));
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
