import 'package:eliud_core/model/image_model.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../incidamus_app.dart';

class WhoImages {
  final Tools newAppTools;

  WhoImages(this.newAppTools);

  Future<void> run() async {
    await newAppTools.getImgModel(name: "iphone", appId: IncidamusApp.INCIDAMUS_APP_ID, url: "https://live.staticflickr.com/65535/50714066597_1be6432eb3_w_d.jpg");
    await newAppTools.getImgModel(name: "tablet", appId: IncidamusApp.INCIDAMUS_APP_ID, url: "https://live.staticflickr.com/65535/49793810848_7fd90874f7_w_d.jpg");
    await newAppTools.getImgModel(name: "macbook", appId: IncidamusApp.INCIDAMUS_APP_ID, url: "https://live.staticflickr.com/65535/49794663897_cba001e135_w_d.jpg");
    await newAppTools.getImgModel(name: "android", appId: IncidamusApp.INCIDAMUS_APP_ID, url: "https://live.staticflickr.com/65535/49794009143_bf7a5a0174_w_d.jpg");
  }
}
