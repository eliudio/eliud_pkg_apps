import 'package:eliud_core_main/model/model_export.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_core_main/storage/member_medium_helper.dart';
import 'package:eliud_core_main/storage/platform_medium_helper.dart';
import 'package:eliud_core_main/storage/public_medium_helper.dart';
import 'package:eliud_core_model/model/member_medium_container_model.dart';

class ImageTools {
  static Future<PublicMediumModel> uploadPublicPhoto(
      AppModel app, MemberModel member, String assetPath) async {
    String docID = newRandomKey();
    return await PublicMediumHelper(
      app,
      member.documentID,
    ).createThumbnailUploadPhotoAsset(
      docID,
      assetPath,
    );
  }

  static Future<PlatformMediumModel> uploadPlatformPhoto(
      AppModel app,
      MemberModel member,
      String assetPath,
      PrivilegeLevelRequiredSimple privilegeLevelRequiredSimple) async {
    String docID = newRandomKey();
    return await PlatformMediumHelper(
            app, member.documentID, privilegeLevelRequiredSimple)
        .createThumbnailUploadPhotoAsset(
      docID,
      assetPath,
    );
  }

  static Future<PlatformMediumModel> uploadPlatformVideo(
      AppModel app,
      MemberModel member,
      String assetPath,
      PrivilegeLevelRequiredSimple privilegeLevelRequiredSimple) async {
    String docID = newRandomKey();
    return await PlatformMediumHelper(
            app, member.documentID, privilegeLevelRequiredSimple)
        .createThumbnailUploadVideoAsset(
      docID,
      assetPath,
    );
  }

  static Future<PlatformMediumModel> uploadPlatformPdf(
      AppModel app,
      MemberModel member,
      String assetPath,
      String documentID,
      PrivilegeLevelRequiredSimple privilegeLevelRequiredSimple) async {
    String docID = newRandomKey();
    return await PlatformMediumHelper(
            app, member.documentID, privilegeLevelRequiredSimple)
        .createThumbnailUploadPdfAsset(docID, assetPath, documentID);
  }

  static Future<PublicMediumModel> uploadPublicPdf(AppModel app,
      MemberModel member, String assetPath, String documentID) async {
    String docID = newRandomKey();
    return await PublicMediumHelper(app, member.documentID)
        .createThumbnailUploadPdfAsset(docID, assetPath, documentID);
  }

  static Future<MemberMediumModel> createMemberMediumModelPhoto(
      AppModel app, MemberModel member, String assetPath) async {
    String docID = newRandomKey();
    var photo = await MemberMediumHelper(
            app, member.documentID, MemberMediumAccessibleByGroup.public)
        .createThumbnailUploadPhotoAsset(
      docID,
      assetPath,
    );
    return photo;
  }

  static Future<MemberMediumContainerModel> createPostMediumModelPhoto(
      AppModel app, MemberModel member, String assetPath) async {
    var photo = await createMemberMediumModelPhoto(app, member, assetPath);
    return MemberMediumContainerModel(
      documentID: newRandomKey(),
      memberMedium: photo,
    );
  }

  static Future<MemberMediumContainerModel> createPostMediumModelVideo(
      AppModel app, MemberModel member, String assetPath) async {
    String docID = newRandomKey();
    var video = await MemberMediumHelper(
            app, member.documentID, MemberMediumAccessibleByGroup.public)
        .createThumbnailUploadVideoAsset(
      docID,
      assetPath,
    );
    return MemberMediumContainerModel(
      documentID: newRandomKey(),
      memberMedium: video,
    );
  }
}
