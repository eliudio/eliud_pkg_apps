import 'dart:async';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart'
    as pr;
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../minkey_app.dart';
import 'example_profile.dart';

class ExamplePosts {
  final PostAccessibleByGroup accessibleByGroup;

  ExamplePosts(this.accessibleByGroup);

  Future<void> run(MemberModel member, String feedId) async {
    var memberPublicInfo =
        await memberPublicInfoRepository()!.get(member.documentID);
    if (memberPublicInfo == null) {
      throw Exception("ERROR: can't retrieve member data");
    }
    for (int j = 0; j < 1; j++) {
      //int j = 0;
      //int i = j * 21;
      try {
        await pr.AbstractRepositorySingleton.singleton
            .postRepository(MinkeyApp.minkeyAppId)!
            .add(PostModel(
                documentID: "example1",
                feedId: feedId,
                authorId: memberPublicInfo.documentID,
                appId: MinkeyApp.minkeyAppId,
                postAppId: JuuwleApp.juuwleAppId,
                postPageId: ProductPage.identifier,
                pageParameters: {'productId': Products.productId2},
                archived: PostArchiveStatus.Active,
                description:
                    'Hi guys, this is another post, this time about another product in my shop',
                accessibleByGroup: accessibleByGroup));
      } catch (e) {
        print(e);
      }
    }

    await pr.AbstractRepositorySingleton.singleton
        .postRepository(MinkeyApp.minkeyAppId)!
        .add(PostModel(
          documentID: "exampleHtml",
          feedId: feedId,
          authorId: memberPublicInfo.documentID,
          appId: MinkeyApp.minkeyAppId,
          archived: PostArchiveStatus.Active,
          html: kHtml,
          accessibleByGroup: accessibleByGroup,
          readAccess: [
            memberPublicInfo.documentID
          ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
        ));

    await pr.AbstractRepositorySingleton.singleton
        .postRepository(MinkeyApp.minkeyAppId)!
        .add(
          PostModel(
            documentID: "example2",
            feedId: feedId,
            authorId: memberPublicInfo.documentID,
            appId: MinkeyApp.minkeyAppId,
            archived: PostArchiveStatus.Active,
            description: "Hi guys, this is my first post these are photos",
            accessibleByGroup: accessibleByGroup,
            memberMedia: [
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
              await ImageTools.createPostMediumModelPhoto(MinkeyApp.app, member,
                  'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
            ],
          ),
        );

    await pr.AbstractRepositorySingleton.singleton
        .postRepository(MinkeyApp.minkeyAppId)!
        .add(
          PostModel(
            documentID: "example3",
            feedId: feedId,
            authorId: memberPublicInfo.documentID,
            appId: MinkeyApp.minkeyAppId,
            archived: PostArchiveStatus.Active,
            description: "Hi guys, this is my first post these are videos",
            accessibleByGroup: accessibleByGroup,
            memberMedia: [],
          ),
        );
  }
}
