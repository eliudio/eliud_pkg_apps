import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_shop/model/product_image_model.dart';
import 'package:eliud_pkg_shop/model/product_model.dart';
import 'package:eliud_pkg_shop/model/shop_model.dart';

import '../../app_base.dart';

class Product {
  final String? id;
  final String? title;
  final String? about;
  final String? assetLocation1;
  final String? assetLocation2;
  final String? assetLocation3;
  final String? assetLocation4;
  final double? price;

  Product({this.id, this.title, this.about, this.assetLocation1, this.assetLocation2, this.assetLocation3, this.assetLocation4, this.price});

  String imageId1() => title! + "a";
  String imageId2() => title! + "b";
}

Future<ProductModel> productToProductModel(ShopModel shop, InstallApp installApp, Product product) async {
  List<ProductImageModel> productImages = [];
  if (product.assetLocation1 != null) {
    productImages.add(ProductImageModel(
        documentID: product.imageId1(),
        image: await ImageTools.uploadPlatformPhoto(
            installApp.appId, installApp.member!, product.assetLocation1!)));
  }
  if (product.assetLocation2 != null) {
    productImages.add(ProductImageModel(
        documentID: product.imageId1(),
        image: await ImageTools.uploadPlatformPhoto(
            installApp.appId, installApp.member!, product.assetLocation2!)));
  }
  if (product.assetLocation3 != null) {
    productImages.add(ProductImageModel(
        documentID: product.imageId1(),
        image: await ImageTools.uploadPlatformPhoto(
            installApp.appId, installApp.member!, product.assetLocation3!)));
  }
  if (product.assetLocation4 != null) {
    productImages.add(ProductImageModel(
        documentID: product.imageId1(),
        image: await ImageTools.uploadPlatformPhoto(
            installApp.appId, installApp.member!, product.assetLocation4!)));
  }
  return new ProductModel(
    documentID: product.id,
    appId: installApp.appId,
    title: product.title,
    about: product.about,
    shop: shop,
    images: productImages,
    price: product.price,
    weight: 100,
    posSize: installApp.screen75(),
    conditions: StorageConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
    ),
  );
}
