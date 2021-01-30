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
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart' as memberRepo;

import '../minkey_app.dart';

class ExampleFeed {
  final Tools newAppTools;

  ExampleFeed(this.newAppTools);

  Future<void> run(MemberModel member) async {
    var memberPublicInfo = await memberRepo.memberPublicInfoRepository().get(member.documentID);
//    for (int j = 0; j < 1; j++) {
    int j = 0;
      int i = j * 21;
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 1).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId1},
          archived: PostArchiveStatus.Active,
          description: "Hi guys, this is my first post and it's about a product in my shop",
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 2).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId2},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 3).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId3},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 4).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId4},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 5).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId3},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 6).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId5},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 7).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId6},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 8).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId7},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 9).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId8},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 10).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId9},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 11).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId10},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 12).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId11},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 13).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId12},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 14).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId13},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 15).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId14},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 16).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          archived: PostArchiveStatus.Active,
          pageParameters: {'productId': Products.productId15},
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 17).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId16},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 18).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: Shop.identifier,
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 19).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          postAppId: MinkeyApp.MINKEY_APP_ID,
          postPageId: AboutBase.identifier,
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about the about of the Minkey app',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 20).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          archived: PostArchiveStatus.Active,
          postAppId: JuuwleApp.JUUWLE_APP_ID,
          postPageId: AboutBase.identifier,
          description: 'Hi guys, this is another post, this time about the about of the Juuwle app',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: (i + 21).toString(),
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          archived: PostArchiveStatus.Active,
          postAppId: EliudApp.ELIUD_APP_ID,
          postPageId: AboutBase.identifier,
          description: 'Hi guys, this is another post, this time about the about of the Eliud app',
          readAccess: ['PUBLIC']));
//    }
  }
}
