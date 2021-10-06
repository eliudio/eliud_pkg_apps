
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/platform_medium_helper.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';

class ImageTools {
  static Future<PlatformMediumModel> uploadPublicPhoto(String appId, MemberModel member, String assetPath) async {
    String memberMediumDocumentID = newRandomKey();
    return await PlatformMediumHelper(appId, member.documentID!, PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple).createThumbnailUploadPhotoAsset(memberMediumDocumentID, assetPath, );
  }

  static Future<PlatformMediumModel> uploadPublicVideo(String appId, MemberModel member, String assetPath) async {
    String memberMediumDocumentID = newRandomKey();
    return await PlatformMediumHelper(appId, member.documentID!, PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple).createThumbnailUploadVideoAsset(memberMediumDocumentID, assetPath, );
  }

  static Future<PlatformMediumModel> uploadPublicPdf(String appId, MemberModel member, String assetPath, String documentID) async {
    String memberMediumDocumentID = newRandomKey();
    return await PlatformMediumHelper(appId, member.documentID!, PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple).createThumbnailUploadPdfAsset(memberMediumDocumentID, assetPath, documentID);
  }

  static Future<MemberMediumModel> createMemberMediumModelPhoto(String appId, MemberModel member, String assetPath) async {
    String memberMediumDocumentID = newRandomKey();
    var photo = await MemberMediumHelper(appId, member.documentID!, ['PUBLIC',member.documentID!]).createThumbnailUploadPhotoAsset(memberMediumDocumentID, assetPath, );
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
    String memberMediumDocumentID = newRandomKey();
    var video = await MemberMediumHelper(appId, member.documentID!, ['PUBLIC',member.documentID!]).createThumbnailUploadVideoAsset(memberMediumDocumentID, assetPath, );
    return PostMediumModel(
      documentID: newRandomKey(),
      memberMedium: video,
    );
  }

}
