import 'package:eliud_core/model/dialog_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';

import '../../install_app.dart';

class JuuwleMemberDashboard extends MemberDashboard {
  JuuwleMemberDashboard({InstallApp? installApp}) :
        super(installApp);
  Future<DialogModel> run() async {
    return super.run();
  }
}
