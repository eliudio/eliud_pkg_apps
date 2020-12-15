import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_pkg_apps/apps/shared/notifications/dashboard.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/minkey_app/minkey_app.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/dashboard_component.dart';
import 'package:eliud_pkg_notifications/model/dashboard_model.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';

import '../../app_section.dart';
import '../../app_base.dart';
import 'example_notifications.dart';

class MinkeyDashboard extends Dashboard {
  MinkeyDashboard({InstallApp installApp, Tools newAppTools, BackgroundModel pageBG}) :
        super(installApp, newAppTools, pageBG);
  Future<DialogModel> run() async {
    await ExampleNotifications(newAppTools).run();
    return super.run();
  }
}
