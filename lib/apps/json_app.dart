import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/components/page_constructors/eliud_appbar.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
as corerepo;
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/style/frontend/has_drawer.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_create/tools/defaults.dart' as defaults;
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/grid_views.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/policies/policy_page.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/divider_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;
import 'package:flutter/services.dart' show rootBundle;
import 'package:eliud_pkg_create/jsontomodeltojson/jsontomodelhelper.dart';

import 'app_base.dart';

abstract class JsonApp extends AppBase {
  JsonApp(AppModel theApp): super(theApp);

  Future<String> getJson() async {
    try {
      var json = await rootBundle.loadString(jsonLocation());;
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