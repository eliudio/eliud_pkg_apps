import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/eliud_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/shop.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../minkey_app.dart';

class ExampleFeed {
  final Tools newAppTools;

  ExampleFeed(this.newAppTools);

  Future<void> run(MemberModel member) async {
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '1',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId1},
        description: "Hi guys, this is my first post and it's about a product in my shop",
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '2',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId2},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '3',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId3},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '4',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId4},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '4',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId3},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '5',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId5},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '6',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId6},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '7',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId7},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '8',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId8},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '9',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId9},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '10',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId10},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '11',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId11},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '12',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId12},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '13',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId13},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '14',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId14},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '15',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId15},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '16',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId16},
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '17',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: Shop.identifier,
        description: 'Hi guys, this is another post, this time about my shop',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '17',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  MinkeyApp.MINKEY_APP_ID,
        postPageId: AboutBase.identifier,
        description: 'Hi guys, this is another post, this time about the about of the Minkey app',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '18',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  JuuwleApp.JUUWLE_APP_ID,
        postPageId: AboutBase.identifier,
        description: 'Hi guys, this is another post, this time about the about of the Juuwle app',
        readAccess: ['PUBLIC']));
    await AbstractRepositorySingleton.singleton.postRepository(MinkeyApp.MINKEY_APP_ID).add(PostModel(
        documentID: '19',
        author: member,
        appId:  MinkeyApp.MINKEY_APP_ID,
        postAppId:  EliudApp.ELIUD_APP_ID,
        postPageId: AboutBase.identifier,
        description: 'Hi guys, this is another post, this time about the about of the Eliud app',
        readAccess: ['PUBLIC']));
  }
}
