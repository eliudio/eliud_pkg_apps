import 'package:eliud_core_model/model/app_model.dart';

import '../json_app.dart';

class JuuwleJsonApp extends JsonApp {
  static String juuwleAppId = "JUUWLE";

  static AppModel app = AppModel(documentID: juuwleAppId, ownerID: '?');

  JuuwleJsonApp() : super(app);

  @override
  String jsonLocation() =>
      'packages/eliud_pkg_apps/assets/json_apps/juuwle.json';
}
