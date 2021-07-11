import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/incidamus_app/feed/feed.dart';
import 'package:eliud_pkg_apps/apps/shared/follow/follow_dashboards.dart';
import 'package:eliud_pkg_feed/extensions/profile/profile.dart';

import '../../app_base.dart';

class IncidamusFollowDashboards extends FollowDashboards {
  IncidamusFollowDashboards({InstallApp? installApp, RgbModel? backgroundColor}) :
        super(installApp, backgroundColor);
  Future<DialogModel> run() async {
    return super.runIt(null, Feed.IDENTIFIER);
  }
}
