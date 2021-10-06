
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';

class ImageToolsX {
  static Future<MemberMediumModel> uploadPublicPhoto(String appId, MemberModel member, String assetPath) async {
    String memberMediumDocumentID = newRandomKey();
    return await MemberMediumHelper.createThumbnailUploadPhotoAsset(memberMediumDocumentID, appId, assetPath, member.documentID!, ['PUBLIC',member.documentID!]);
  }

  static Future<MemberMediumModel> uploadPublicVideo(String appId, MemberModel member, String assetPath) async {
    String memberMediumDocumentID = newRandomKey();
    return await MemberMediumHelper.createThumbnailUploadVideoAsset(memberMediumDocumentID, appId, assetPath, member.documentID!, ['PUBLIC',member.documentID!]);
  }

  static Future<MemberMediumModel> uploadPublicPdf(String appId, MemberModel member, String assetPath, String documentID) async {
    String memberMediumDocumentID = newRandomKey();
    return await MemberMediumHelper.createThumbnailUploadPdfAsset(memberMediumDocumentID, appId, assetPath, member.documentID!, ['PUBLIC',member.documentID!], documentID);
  }

  static Future<MemberMediumModel> createMemberMediumModelPhoto(String appId, MemberModel member, String assetPath) async {
    String memberMediumDocumentID = newRandomKey();
    var photo = await MemberMediumHelper.createThumbnailUploadPhotoAsset(memberMediumDocumentID, appId, assetPath, member.documentID!, ['PUBLIC',member.documentID!]);
    return photo;
  }

  static Future<PostMediumModel> createPostMediumModelPhoto(String appId, MemberModel member, String assetPath) async {
    var photo = await createMemberMediumModelPhoto(appId, member, assetPath);
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
