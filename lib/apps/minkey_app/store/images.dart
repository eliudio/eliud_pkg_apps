import 'package:eliud_core/model/image_model.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../minkey_app.dart';

class WhoImages {
  final Tools newAppTools;

  WhoImages(this.newAppTools);

  Future<ImageModel> run() {
    return newAppTools.getImgModel(name: "minkey", appId: MinkeyApp.MINKEY_APP_ID, url: "https://live.staticflickr.com/65535/49886057112_55cb16cb68_o_d.png");
  }
}
