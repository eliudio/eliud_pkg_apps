import 'package:eliud_core_model/model/app_model.dart';

import '../json_app.dart';

class EliudJsonApp extends JsonApp {
  static String eliudAppId = "ELIUD_APP_JSON";

  static AppModel app = AppModel(documentID: eliudAppId, ownerID: '?');

  EliudJsonApp() : super(app);

  @override
  String jsonLocation() =>
      'packages/eliud_pkg_apps/assets/json_apps/eliud.json';
}
