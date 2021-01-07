import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

class BlockedImages {
  final Tools newAppTools;

  BlockedImages(this.newAppTools);

  static String blockedePhoto = "blockedPhoto";

  Future<void> run() async {
    await newAppTools.getImgModel(name: blockedePhoto, appId: MinkeyApp.MINKEY_APP_ID, url: "https://live.staticflickr.com/65535/50810109516_f02a56948a_o_d.png");
  }
}
