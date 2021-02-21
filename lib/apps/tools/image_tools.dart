import 'dart:collection';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/storage/uploadfile.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_component.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_entry_model.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_model.dart';

class ImageTools {
  static Future<MemberMediumModel> uploadPublicPhoto(String appId, MemberModel member, String assetPath) async {
    return await UploadFile.createThumbnailUploadPhotoAsset(appId, assetPath, member.documentID, ['PUBLIC']);
  }

  static Future<MemberMediumModel> uploadPublicVideo(String appId, MemberModel member, String assetPath) async {
    return await UploadFile.createThumbnailUploadVideoAsset(appId, assetPath, member.documentID, ['PUBLIC']);
  }

}
