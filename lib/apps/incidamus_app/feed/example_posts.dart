import 'dart:async';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/incidamus_app.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart' as postRepo;
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../incidamus_app.dart';

class ExamplePosts {
  final String? appId;

  ExamplePosts(this.appId);
  
  Future<void> run(MemberModel member, String feedId) async {
//    for (int j = 0; j < 1; j++) {
    int j = 0;
    int i = j * 21;
    await postRepo.AbstractRepositorySingleton.singleton.postRepository(
        IncidamusApp.INCIDAMUS_APP_ID)!.add(PostModel(
        documentID: "example1",
        feedId: feedId,
        authorId: member.documentID!,
        appId: IncidamusApp.INCIDAMUS_APP_ID,
        postAppId: IncidamusApp.INCIDAMUS_APP_ID,
        postPageId: ProductPage.identifier,
        pageParameters: {'productId': Products.productId1},
        archived: PostArchiveStatus.Active,
        description: 'Hi guys, this is another post, this time about another product in my shop',
        readAccess: ['PUBLIC']));

    await postRepo.AbstractRepositorySingleton.singleton.postRepository(
        IncidamusApp.INCIDAMUS_APP_ID)!.add(PostModel(
      documentID: "example2",
      feedId: feedId,
      authorId: member.documentID!,
      appId: IncidamusApp.INCIDAMUS_APP_ID,
      archived: PostArchiveStatus.Active,
      description: "Hi guys, this is my first post these are photos",
      readAccess: ['PUBLIC'],
      memberMedia: [
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_photo3.jpg'),
      ],
    ),
    );

    await postRepo.AbstractRepositorySingleton.singleton.postRepository(
        IncidamusApp.INCIDAMUS_APP_ID)!.add(PostModel(
      documentID: "example3",
      feedId: feedId,
      authorId: member.documentID!,
      appId: IncidamusApp.INCIDAMUS_APP_ID,
      archived: PostArchiveStatus.Active,
      description: "Hi guys, this is my first post these are videos",
      readAccess: ['PUBLIC'],
      memberMedia: [
        await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
        await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
        await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
        await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
        await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
        await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
      ],
    ),
    );


      /*await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 2).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId2},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 3).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId3},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 4).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId4},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 5).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId3},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 6).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId5},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 7).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId6},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 8).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId7},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 9).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId8},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 10).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId9},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 11).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId10},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 12).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId11},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 13).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId12},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 14).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId13},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 15).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId14},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 16).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          archived: PostArchiveStatus.Active,
          pageParameters: {'productId': Products.productId15},
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 17).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: ProductPage.identifier,
          pageParameters: {'productId': Products.productId16},
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about another product in my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 18).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: Shop.identifier,
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about my shop',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 19).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: AboutBase.identifier,
          archived: PostArchiveStatus.Active,
          description: 'Hi guys, this is another post, this time about the about of the Incidamus app',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 20).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          archived: PostArchiveStatus.Active,
          postAppId: IncidamusApp.INCIDAMUS_APP_ID,
          postPageId: AboutBase.identifier,
          description: 'Hi guys, this is another post, this time about the about of the Juuwle app',
          readAccess: ['PUBLIC']));
      await AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: (i + 21).toString(),
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          archived: PostArchiveStatus.Active,
          postAppId: EliudApp.ELIUD_APP_ID,
          postPageId: AboutBase.identifier,
          description: 'Hi guys, this is another post, this time about the about of the Eliud app',
          readAccess: ['PUBLIC']));*/
//    }
  }
}
