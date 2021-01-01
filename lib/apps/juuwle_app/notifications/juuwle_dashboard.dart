import 'package:eliud_pkg_apps/apps/shared/notifications/dashboard.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../app_base.dart';

class JuuwleDashboard extends Dashboard {
  JuuwleDashboard({InstallApp installApp, Tools newAppTools, RgbModel backgroundColor}) :
        super(installApp, newAppTools, backgroundColor);
  Future<DialogModel> run() async {
    return super.run();
  }
}
