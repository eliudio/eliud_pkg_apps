import 'package:eliud_model/shared/image_model.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../minkey_app.dart';

class WhoImages {
  final Tools newAppTools;

  WhoImages(this.newAppTools);

  Future<ImageModel> run() {
    return newAppTools.getImgModel(name: "iphone", appId: MinkeyApp.MINKEY_APP_ID, url: "https://live.staticflickr.com/65535/49794358181_47386fdbac_o_d.jpg")
        .then((_) => newAppTools.getImgModel(name: "tablet", appId: MinkeyApp.MINKEY_APP_ID, url: "https://live.staticflickr.com/65535/49793810848_c3cdbaffa0_o_d.jpg"))
        .then((_) => newAppTools.getImgModel(name: "macbook", appId: MinkeyApp.MINKEY_APP_ID, url: "https://live.staticflickr.com/65535/49794663897_b6f6f90987_o_d.jpg"))
        .then((_) => newAppTools.getImgModel(name: "android", appId: MinkeyApp.MINKEY_APP_ID, url: "https://live.staticflickr.com/65535/49794009143_00b5d358c2_o_d.jpg"));
  }
}
