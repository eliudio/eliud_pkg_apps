import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_apps/apps/shared/notifications/notification_dashboard.dart';

import '../../install_app.dart';

class JuuwleNotificationDashboard extends NotificationDashboard {
  JuuwleNotificationDashboard({InstallApp? installApp}) :
        super(installApp);
  Future<DialogModel> run() async {
    return super.run();
  }
}
