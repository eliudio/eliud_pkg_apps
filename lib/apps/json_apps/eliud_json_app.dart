import 'package:eliud_core/model/app_model.dart';

import '../json_app.dart';

class EliudJsonApp extends JsonApp {
  static String ELIUD_APP_ID = "ELIUD_APP_JSON";

  static AppModel app = AppModel(documentID: ELIUD_APP_ID, ownerID: '?');

  EliudJsonApp() : super(app);

  String jsonLocation() => 'packages/eliud_pkg_apps/assets/json_apps/eliud.json';
}
