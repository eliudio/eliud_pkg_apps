import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../juuwle_app.dart';

class ShopImages {
  final Tools newAppTools;

  ShopImages(this.newAppTools);

  static String shopImageId = "shopImage";

  Future<void> run() async {
    await newAppTools.getImgModel(name: shopImageId, appId: JuuwleApp.JUUWLE_APP_ID, url: "https://live.staticflickr.com/65535/50015557987_5ef4cde6c0_o_d.png");
  }
}
