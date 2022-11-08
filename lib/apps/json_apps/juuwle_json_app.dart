import 'package:eliud_core/model/app_model.dart';

import '../json_app.dart';

class JuuwleJsonApp extends JsonApp {
  static String JUUWLE_APP_ID = "JUUWLE";

  static AppModel app = AppModel(documentID: JUUWLE_APP_ID, ownerID: '?');

  JuuwleJsonApp() : super(app);

  String jsonLocation() => 'packages/eliud_pkg_apps/assets/json_apps/juuwle.json';
}
