import 'package:eliud_core/model/image_model.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../eliud_app.dart';

class WelcomeImages {
  final Tools newAppTools;

  WelcomeImages(this.newAppTools);

  Future<void> run() async {
    await newAppTools.getImgModel(name: "iphone", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49794358181_fbd00cd97e_w_d.jpg");
    await newAppTools.getImgModel(name: "tablet", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49793810848_7fd90874f7_w_d.jpg");
    await newAppTools.getImgModel(name: "macbook", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49794663897_cba001e135_w_d.jpg");
    await newAppTools.getImgModel(name: "android", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49794009143_bf7a5a0174_w_d.jpg");
  }
}
