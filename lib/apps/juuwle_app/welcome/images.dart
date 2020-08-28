import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../juuwle_app.dart';

class WelcomeImages {
  final Tools newAppTools;

  WelcomeImages(this.newAppTools);

  static String photo1 = "example1";
  static String photo2 = "example2";
  static String photo3 = "example3";
  static String welcomePhoto = "welcomePhoto";

  Future<void> run() async {
    await newAppTools.getImgModel(name: photo1, appId: JuuwleApp.JUUWLE_APP_ID, url: "https://live.staticflickr.com/65535/49966809498_26dfb13965_k_d.jpg");
    await newAppTools.getImgModel(name: photo2, appId: JuuwleApp.JUUWLE_APP_ID, url: "https://live.staticflickr.com/65535/49967318611_707f1bf745_k_d.jpg");
    await newAppTools.getImgModel(name: photo3, appId: JuuwleApp.JUUWLE_APP_ID, url: "https://live.staticflickr.com/65535/49967318581_e03a634241_k_d.jpg");
    await newAppTools.getImgModel(name: welcomePhoto, appId: JuuwleApp.JUUWLE_APP_ID, url: "https://live.staticflickr.com/65535/49978159872_1591954160_o_d.png");
  }
}
