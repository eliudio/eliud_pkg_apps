import 'package:eliud_core/model/app_model.dart';

import '../json_app.dart';

class MinkeyJsonApp extends JsonApp {
  static String MINKEY_APP_ID = "MINKEY_APP2";

  static AppModel app = AppModel(documentID: MINKEY_APP_ID, ownerID: '?');

  MinkeyJsonApp() : super(app);

  String jsonLocation() => 'packages/eliud_pkg_apps/assets/json_apps/minkey.json';
}
