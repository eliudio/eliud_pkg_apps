import 'dart:collection';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/firestore_helper.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_component.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_entry_model.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_model.dart';
import 'package:eliud_pkg_post/model/post_medium_model.dart';

class ImageTools {
  static Future<MemberMediumModel> uploadPublicPhoto(String appId, MemberModel member, String assetPath) async {
    return await UploadFile.createThumbnailUploadPhotoAsset(appId, assetPath, member.documentID, ['PUBLIC',member.documentID]);
  }

  static Future<MemberMediumModel> uploadPublicVideo(String appId, MemberModel member, String assetPath) async {
    return await UploadFile.createThumbnailUploadVideoAsset(appId, assetPath, member.documentID, ['PUBLIC',member.documentID]);
  }

  static Future<MemberMediumModel> uploadPublicPdf(String appId, MemberModel member, String assetPath, {String documentID}) async {
    return await UploadFile.createThumbnailUploadPdfAsset(appId, assetPath, member.documentID, ['PUBLIC',member.documentID], documentID: documentID);
  }

  static Future<PostMediumModel> createPostMediumModelPhoto(String appId, MemberModel member, String assetPath) async {
    var photo = await UploadFile.createThumbnailUploadPhotoAsset(appId, assetPath, member.documentID, ['PUBLIC',member.documentID]);
    return PostMediumModel(
      documentID: newRandomKey(),
      memberMedium: photo,
    );
  }

  static Future<PostMediumModel> createPostMediumModelVideo(String appId, MemberModel member, String assetPath) async {
    var video = await uploadPublicVideo(appId, member, assetPath);
    return PostMediumModel(
      documentID: newRandomKey(),
      memberMedium: video,
    );
  }

}
