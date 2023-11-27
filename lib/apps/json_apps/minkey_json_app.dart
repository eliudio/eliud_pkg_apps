import 'package:eliud_core_main/model/app_model.dart';

import '../json_app.dart';

class MinkeyJsonApp extends JsonApp {
  static String minkeyAppId = "MINKEY_APP";

  static AppModel app = AppModel(documentID: minkeyAppId, ownerID: '?');

  MinkeyJsonApp() : super(app);

  @override
  String jsonLocation() =>
      'packages/eliud_pkg_apps/assets/json_apps/minkey.json';
}
