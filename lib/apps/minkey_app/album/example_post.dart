import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:eliud_pkg_post/model/abstract_repository_singleton.dart' as postRepo;
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart' as memberRepo;
import 'package:eliud_pkg_post/model/post_model.dart';
import 'package:eliud_pkg_storage/model/member_medium_model.dart';
import 'package:eliud_pkg_storage/tools/uploadfile.dart';

import '../minkey_app.dart';
import 'dart:async';

class ExamplePost {
  final String appId;
  final Tools newAppTools;

  static String ALBUM_POST_PHOTOS = "photoalbum";
  static String ALBUM_POST_MOVIES = "videoalbum";

  ExamplePost(this.newAppTools, this.appId);

  Future<MemberMediumModel> uploadPhoto(MemberModel member, String assetName) async {
    return await UploadFile.createThumbnailUploadPhotoAsset(appId, assetName, member.documentID, ['PUBLIC']);
  }

  Future<MemberMediumModel> uploadVideo(MemberModel member, String assetName) async {
    return await UploadFile.createThumbnailUploadVideoAsset(appId, assetName, member.documentID, ['PUBLIC']);
  }

  Future<PostModel> photoAlbum(MemberModel member) async {
    var memberPublicInfo = await memberRepo.memberPublicInfoRepository().get(member.documentID);
    return await postRepo.AbstractRepositorySingleton.singleton.postRepository(
        MinkeyApp.MINKEY_APP_ID).add(PostModel(
      documentID: ALBUM_POST_PHOTOS,
      author: memberPublicInfo,
      appId: MinkeyApp.MINKEY_APP_ID,
      archived: PostArchiveStatus.Active,
      description: "These are my photos",
      readAccess: ['PUBLIC'],
      memberMedia: [
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
        await uploadPhoto(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
      ],
    ),
    );
  }

  Future<PostModel> videoAlbum(MemberModel member) async {
      var memberPublicInfo = await memberRepo.memberPublicInfoRepository().get(member.documentID);
      return await postRepo.AbstractRepositorySingleton.singleton.postRepository(
          MinkeyApp.MINKEY_APP_ID).add(PostModel(
          documentID: ALBUM_POST_MOVIES,
          author: memberPublicInfo,
          appId: MinkeyApp.MINKEY_APP_ID,
          archived: PostArchiveStatus.Active,
          description: "These are my videos",
          readAccess: ['PUBLIC'],
          memberMedia: [
            await uploadVideo(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await uploadVideo(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await uploadVideo(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await uploadVideo(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
            await uploadVideo(member, 'packages/eliud_pkg_apps/assets/minkey_app/feed/example_video1.mp4'),
          ],
        ),
      );
  }
}
