import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../../app_base.dart';

class IncidamusMembershipDashboard extends MembershipDashboard {
  IncidamusMembershipDashboard({InstallApp installApp, Tools newAppTools, RgbModel backgroundColor}) :
        super(installApp, newAppTools, backgroundColor);
  Future<DialogModel> run() async {
    return super.run();
  }
}
