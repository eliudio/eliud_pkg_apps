import 'dart:async';
import 'package:eliud_core_main/tools/main_abstract_repository_singleton.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:eliud_pkg_create/jsontomodeltojson/jsontomodelhelper.dart';

import 'app_base.dart';

abstract class JsonApp extends AppBase {
  JsonApp(super.theApp);

  Future<String> getJson() async {
    try {
      var json = await rootBundle.loadString(jsonLocation());
      return json;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  Future<void> run(String ownerID) async {
    var json = await getJson();
    var tasks = await JsonToModelsHelper.createAppFromJson(
        theApp, member!.documentID, json);

    int i = 0;
    for (var task in tasks) {
      i++;
      try {
        await task();
      } catch (e) {
        print('Exception running task $i, error: $e');
      }
    }

    appRepository(appId: theApp.documentID)!.flush();
  }

  String jsonLocation();
}
