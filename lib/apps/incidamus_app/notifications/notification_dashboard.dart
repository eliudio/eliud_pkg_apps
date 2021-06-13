import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';

import '../../app_base.dart';

class IncidamusNotificationDashboard extends NotificationDashboard {
  IncidamusNotificationDashboard({InstallApp? installApp, RgbModel? backgroundColor}) :
        super(installApp, backgroundColor);
  Future<DialogModel> run() async {
    return super.run();
  }
}
