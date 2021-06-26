import 'dart:async';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart' as postRepo;
import 'package:eliud_pkg_feed/model/post_model.dart';

import '../minkey_app.dart';

class ExamplePost {
  final String? appId;

  static String ALBUM_POST_PHOTOS = "photoalbum";
  static String ALBUM_POST_MOVIES = "videoalbum";

  ExamplePost(this.appId);

  Future<PostModel> photoAlbum(MemberModel member) async {
    var memberPublicInfo = await memberPublicInfoRepository()!.get(member.documentID);
    return await postRepo.AbstractRepositorySingleton.singleton.postRepository(
        MinkeyApp.MINKEY_APP_ID)!.add(PostModel(
      documentID: ALBUM_POST_PHOTOS,
      authorId: memberPublicInfo!.documentID!,
      appId: MinkeyApp.MINKEY_APP_ID,
      archived: PostArchiveStatus.Active,
      description: "These are my photos",
      readAccess: ['PUBLIC', member.documentID!],
      memberMedia: [
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await ImageTools.createPostMediumModelPhoto(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
      ],
    ),
    );
  }

  Future<PostModel> videoAlbum(MemberModel member) async {
      var memberPublicInfo = await memberPublicInfoRepository()!.get(member.documentID);
      return await postRepo.AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID)!.add(PostModel(
          documentID: ALBUM_POST_MOVIES,
        authorId: memberPublicInfo!.documentID!,
          appId: MinkeyApp.MINKEY_APP_ID,
          archived: PostArchiveStatus.Active,
          description: "These are my videos",
          readAccess: ['PUBLIC', member.documentID!],
          memberMedia: [
            await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await ImageTools.createPostMediumModelVideo(appId!, member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
          ],
        ),
      );
  }
}
