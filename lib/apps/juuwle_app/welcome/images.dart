import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../juuwle_app.dart';

class WelcomeImages {
  final Tools newAppTools;

  WelcomeImages(this.newAppTools);

  static String welcomePhoto = "welcomePhoto";

  Future<void> run() async {
    await newAppTools.getImgModel(name: welcomePhoto, appId: JuuwleApp.JUUWLE_APP_ID, url: "https://live.staticflickr.com/65535/50706673333_91f2711a22_o_d.png");
  }
}
