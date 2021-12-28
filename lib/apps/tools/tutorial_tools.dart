
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_component.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_entry_model.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_model.dart';

import 'image_tools.dart';

class TutorialTools {
/*
  Map<String, ImageModel> _images = HashMap();

  Future<MemberMediumModel> uploadPublicPhoto(String appId, MemberModel member, String assetName) async {
    return await UploadFile.createThumbnailUploadPhotoAsset(appId, assetName, member.documentID, ['PUBLIC', member.documentID!]);
  }

  Future<MemberMediumModel> uploadPublicVideo(String appId, MemberModel member, String assetName) async {
    return await UploadFile.createThumbnailUploadVideoAsset(appId, assetName, member.documentID, ['PUBLIC', member.documentID!]);
  }

  ImageModel findImageModel(String documentID) {
    ImageModel image = _images[documentID];
    if (image == null) {
      print("Warning: image $documentID not found");
    }
    return image;
  }


  Future<ImageModel> getImgModel({String documentID, String appId, String name, String url}) async {
    // Create thumbnail and store the image
    if (documentID == null) documentID = name;
    ImageModel model = ImageModel(
        documentID: documentID,
        source: SourceImage.SpecifyURL,
        name: name,
        imageURLOriginal: url,
        appId: appId
    );
    var image = await ImageTools.downloadImage(url, name);
//    var image = null;
    if (image == null) {
      print('issue downloading image with url = $url');
      return model;
    } else {
      await ImageTools.createThumbnail(model, name, image);
      var val = await AbstractMainRepositorySingleton.singleton
          .imageRepository(appId).add(model);
      var img = await AbstractMainRepositorySingleton.singleton
          .imageRepository(appId).get(documentID);
      _images[documentID] = img;
      return img;
    }
  }

*/
  static Future<TutorialModel> constructTutorialModel(MemberModel? member, AppModel app, String tutorialID, String name, String title, String description, String assetRoot, List<String?> assetLocations, List<String?> codes, List<String> descriptions) async {
    assert(assetLocations.length == descriptions.length);
    List<TutorialEntryModel> items = [];
    for (int i = 0; i < assetLocations.length; i++) {
      String assetLocation;
      var image;
      if (assetLocations[i] != null) {
        assetLocation = assetRoot + assetLocations[i]!;
        image = await ImageTools.uploadPlatformPhoto(app, member!, assetLocation);
      }
      String documentID = i.toString();
      items.add(TutorialEntryModel(
          documentID: documentID,
          description: descriptions[i],
          image: image,
          code: codes[i]
      ));
    }

    return TutorialModel(
      documentID: tutorialID,
      appId: app.documentID!,
      name: name,
      title: title,
      description: description,
      tutorialEntries: items,
      conditions: StorageConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  static Future<PageModel> createTutorial(String appId, String tutorialID, String title, DrawerModel? drawer, AppBarModel appBar, HomeMenuModel? homeMenu) async {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1", componentName: AbstractTutorialComponent.componentName, componentId: tutorialID));
    PageModel page = PageModel(
      documentID: tutorialID,
      appId: appId,
      title: title,
      appBar: appBar,
      drawer: drawer,
      homeMenu: homeMenu,
      bodyComponents: components,
      layout: PageLayout.OnlyTheFirstComponent,
      conditions: StorageConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
      ),
    );
    return await AbstractRepositorySingleton.singleton.pageRepository(appId)!.add(page);
  }

}
