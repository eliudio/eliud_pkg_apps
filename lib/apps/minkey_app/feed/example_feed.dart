import 'package:eliud_core/model/image_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../minkey_app.dart';

class ExampleFeed {
  final Tools newAppTools;

  ExampleFeed(this.newAppTools);

  Future<void> run(MemberModel member) async {
    return await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '1',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId1},
        description: 'Hi guys, this is my first product in my shop',
        readAccess: ['PUBLIC']));
  }
}
