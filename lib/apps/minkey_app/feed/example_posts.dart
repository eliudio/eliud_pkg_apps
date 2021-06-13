import 'dart:async';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart'
    as postRepo;
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../minkey_app.dart';
import 'example_profile.dart';

class ExamplePosts {
  final String? appId;
  final List<String> readAccess;

  ExamplePosts(this.appId, this.readAccess);

  Future<void> run(MemberModel member, String feedId) async {
    var memberPublicInfo =
        await memberPublicInfoRepository()!.get(member.documentID);
    if (memberPublicInfo == null) {
      throw Exception("ERROR: can't retrieve member data");
    }
    for (int j = 0; j < 1; j++) {
      int j = 0;
      int i = j * 21;
      try {
        await postRepo.AbstractRepositorySingleton.singleton
            .postRepository(MinkeyApp.MINKEY_APP_ID)!
            .add(PostModel(
                documentID: "example1",
                feedId: feedId,
                author: memberPublicInfo,
                appId: MinkeyApp.MINKEY_APP_ID,
                postAppId: JuuwleApp.JUUWLE_APP_ID,
                postPageId: ProductPage.identifier,
                pageParameters: {'productId': Products.productId2},
                archived: PostArchiveStatus.Active,
                description:
                    'Hi guys, this is another post, this time about another product in my shop',
                readAccess: readAccess));
      } catch (e) {
        print(e);
      }
    }

    await postRepo.AbstractRepositorySingleton.singleton
        .postRepository(MinkeyApp.MINKEY_APP_ID)!
        .add(PostModel(
        documentID: "exampleHtml",
        feedId: feedId,
        author: memberPublicInfo,
        appId: MinkeyApp.MINKEY_APP_ID,
        archived: PostArchiveStatus.Active,
        html: kHtml,
        readAccess: readAccess));

    await postRepo.AbstractRepositorySingleton.singleton
        .postRepository(MinkeyApp.MINKEY_APP_ID)!
        .add(
          PostModel(
            documentID: "example2",
            feedId: feedId,
            author: memberPublicInfo,
            appId: MinkeyApp.MINKEY_APP_ID,
            archived: PostArchiveStatus.Active,
            description: "Hi guys, this is my first post these are photos",
            readAccess: readAccess,
            memberMedia: [
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
            ],
          ),
        );

    await postRepo.AbstractRepositorySingleton.singleton
        .postRepository(MinkeyApp.MINKEY_APP_ID)!
        .add(
          PostModel(
            documentID: "example3",
            feedId: feedId,
            author: memberPublicInfo,
            appId: MinkeyApp.MINKEY_APP_ID,
            archived: PostArchiveStatus.Active,
            description: "Hi guys, this is my first post these are videos",
            readAccess: readAccess,
            memberMedia: [
              await ImageTools.createPostMediumModelVideo(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
              await ImageTools.createPostMediumModelVideo(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
              await ImageTools.createPostMediumModelVideo(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
              await ImageTools.createPostMediumModelVideo(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
              await ImageTools.createPostMediumModelVideo(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
              await ImageTools.createPostMediumModelVideo(appId!, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            ],
          ),
        );
  }
}
