import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'dart:async';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;
import 'package:flutter/services.dart' show rootBundle;
import 'package:eliud_pkg_create/jsontomodeltojson/jsontomodelhelper.dart';

import 'app_base.dart';

abstract class JsonApp extends AppBase {
  JsonApp(AppModel theApp): super(theApp);

  Future<String> getJson() async {
    try {
      var json = await rootBundle.loadString(jsonLocation());
      return json;
    } catch (error) {
      print (error);
      throw error;
    }
  }

  @override
  Future<void> run(String ownerID) async {
    var json = await getJson();
    var tasks = await JsonToModelsHelper.createAppFromJson(theApp, member!.documentID, json);

    int i = 0;
    for (var task in tasks) {
      i++;
      try {
        await task();
      } catch (e) {
        print('Exception running task ' +
            i.toString() +
            ', error: ' +
            e.toString());
      }
    }

    appRepository(appId: theApp.documentID)!.flush();
  }

  String jsonLocation();
}