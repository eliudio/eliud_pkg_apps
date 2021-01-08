import 'dart:collection';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/image_tools.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/tools/types.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_component.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_entry_model.dart';
import 'package:eliud_pkg_fundamentals/model/tutorial_model.dart';

class Tools {
  Map<String, ImageModel> _images = HashMap();

  ImageModel findImageModel(String documentID) {
    ImageModel image = _images[documentID];
    if (image == null) {
      print("Warning: image $documentID not found");
    }
    return image;
  }


  Future<ImageModel> getImgModel({String documentID, String appId, String name, String url, PosSizeModel posSizeModel}) async {
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

  TutorialModel constructTutorialModel(String appId, String tutorialID, String name, String title, String description, List<String> imageIDs, List<String> codes, List<String> descriptions) {
    assert(imageIDs.length == descriptions.length);
    List<TutorialEntryModel> items = [];
    for (int i = 0; i < imageIDs.length; i++) {
      String documentID = i.toString();
      items.add(TutorialEntryModel(
          documentID: documentID,
          description: descriptions[i],
          image: _images[imageIDs[i]],
          code: codes[i]
      ));
    }

    return TutorialModel(
      documentID: tutorialID,
      appId: appId,
      name: name,
      title: title,
      description: description,
      tutorialEntries: items
    );
  }

  Future<PageModel> createTutorial(String appId, String tutorialID, String title, DrawerModel drawer, AppBarModel appBar, HomeMenuModel homeMenu, BackgroundModel backgroundModel) async {
    List<BodyComponentModel> components = List();
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
      background: backgroundModel,
      layout: PageLayout.OnlyTheFirstComponent,
      conditions: ConditionsModel(
        privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
      ),
    );
    return await AbstractRepositorySingleton.singleton.pageRepository(appId).add(page);
  }

}
