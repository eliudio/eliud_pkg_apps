import 'package:eliud_pkg_apps/apps/shared/follow/follow_dashboards.dart';
import 'package:eliud_pkg_apps/apps/shared/membership/membership_dashboard.dart';
import 'package:eliud_core/model/model_export.dart';
import '../../app_base.dart';

class MinkeyFollowDashboards extends FollowDashboards {
  MinkeyFollowDashboards({InstallApp? installApp, RgbModel? backgroundColor}) :
        super(installApp, backgroundColor);
  Future<DialogModel> run() async {
    return super.run();
  }
}
