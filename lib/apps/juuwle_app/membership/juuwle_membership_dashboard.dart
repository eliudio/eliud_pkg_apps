import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';

import '../../install_app.dart';

class JuuwleMembershipDashboard extends MembershipDashboard {
  JuuwleMembershipDashboard({InstallApp? installApp}) :
        super(installApp, null, null);
  Future<DialogModel> run() async {
    return super.run();
  }
}
