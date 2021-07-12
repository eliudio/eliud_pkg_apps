import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/feed/feed.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';

import '../../app_base.dart';

class IncidamusMembershipDashboard extends MembershipDashboard {
  IncidamusMembershipDashboard({InstallApp? installApp}) :
        super(installApp, null, Feed.IDENTIFIER);
  Future<DialogModel> run() async {
    return super.run();
  }
}
