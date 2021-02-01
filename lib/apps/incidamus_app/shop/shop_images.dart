import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../incidamus_app.dart';

class ShopImages {
  final Tools newAppTools;

  ShopImages(this.newAppTools);

  static String shopImageId = "shopImage";

  Future<void> run() async {
    await newAppTools.getImgModel(name: shopImageId, appId: IncidamusApp.INCIDAMUS_APP_ID, url: "https://live.staticflickr.com/65535/50707513357_b5fa84d230_o_d.png");
  }
}
