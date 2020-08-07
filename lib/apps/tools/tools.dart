import 'dart:collection';

import 'package:eliud_model/component/tutorial_component.dart';
import 'package:eliud_model/component/tutorial_model.dart';
import 'package:eliud_model/component/tutorial_entry_model.dart';
import 'package:eliud_model/model/app_bar_model.dart';
import 'package:eliud_model/model/body_component_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';
import 'package:eliud_model/model/page_model.dart';
import 'package:eliud_model/shared/abstract_repository_singleton.dart';
import 'package:eliud_model/shared/background_model.dart';
import 'package:eliud_model/shared/pos_size_model.dart';
import 'package:eliud_model/tools/image_tools.dart';
import 'package:eliud_model/shared/image_model.dart';

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
    return await ImageTools.downloadImage(url, name)
        .then((image) async {
      if (image == null) return null;
      return await ImageTools.createThumbnail(model, name, image)
          .then((model) async {
        return await AbstractRepositorySingleton.singleton.imageRepository()
            .add(model)
            .then((val) async {
          return await AbstractRepositorySingleton.singleton.imageRepository()
              .get(documentID)
              .then((img) {
//            _image = img;
            _images[documentID] = img;
            return img;
          });
        });
      });
    });
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

  Future<PageModel> createTutorial(String appId, String tutorialID, String title, DrawerModel drawer, AppBarModel appBar, HomeMenuModel homeMenu, BackgroundModel backgroundModel) {
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
      conditional: PageCondition.Always,
    );
    return AbstractRepositorySingleton.singleton.pageRepository().add(page);
  }

}
