import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/incidamus_app.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_post/model/abstract_repository_singleton.dart' as postRepo;
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart' as memberRepo;
import 'package:eliud_pkg_post/model/post_model.dart';

import '../incidamus_app.dart';
import 'dart:async';

class ExamplePost {
  final String appId;
  final Tools newAppTools;

  static String ALBUM_POST_PHOTOS = "photoalbum";
  static String ALBUM_POST_MOVIES = "videoalbum";

  ExamplePost(this.newAppTools, this.appId);

  Future<PostModel> photoAlbum(MemberModel member) async {
    var memberPublicInfo = await memberRepo.memberPublicInfoRepository().get(member.documentID);
    return await postRepo.AbstractRepositorySingleton.singleton.postRepository(
        IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
      documentID: ALBUM_POST_PHOTOS,
      author: memberPublicInfo,
      appId: IncidamusApp.INCIDAMUS_APP_ID,
      archived: PostArchiveStatus.Active,
      description: "These are my photos",
      readAccess: ['PUBLIC'],
      memberMedia: [
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/1.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/2.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/3.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/4.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/5.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/6.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/7.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/8.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/9.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/10.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/11.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/12.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/13.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/14.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/15.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/16.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/17.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/18.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/19.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/20.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/21.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/22.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/23.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/24.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/25.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/26.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/27.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/28.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/29.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/30.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/31.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/32.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/33.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/34.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/35.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/36.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/37.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/38.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/39.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/40.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/41.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/42.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/43.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/44.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/45.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/46.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/47.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/48.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/49.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/50.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/51.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/52.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/53.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/54.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/55.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/56.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/57.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/58.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/59.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/60.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/61.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/62.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/63.jpg'),
        await newAppTools.uploadPublicPhoto(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/photos/64.jpg'),

      ],
    ),
    );
  }

  Future<PostModel> videoAlbum(MemberModel member) async {
      var memberPublicInfo = await memberRepo.memberPublicInfoRepository().get(member.documentID);
      return await postRepo.AbstractRepositorySingleton.singleton.postRepository(
          IncidamusApp.INCIDAMUS_APP_ID).add(PostModel(
          documentID: ALBUM_POST_MOVIES,
          author: memberPublicInfo,
          appId: IncidamusApp.INCIDAMUS_APP_ID,
          archived: PostArchiveStatus.Active,
          description: "These are my videos",
          readAccess: ['PUBLIC'],
          memberMedia: [
            await newAppTools.uploadPublicVideo(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
            await newAppTools.uploadPublicVideo(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
            await newAppTools.uploadPublicVideo(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
            await newAppTools.uploadPublicVideo(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
            await newAppTools.uploadPublicVideo(appId, member, 'packages/eliud_pkg_apps/assets/incidamus_app/feed/example_video1.mp4'),
          ],
        ),
      );
  }
}
