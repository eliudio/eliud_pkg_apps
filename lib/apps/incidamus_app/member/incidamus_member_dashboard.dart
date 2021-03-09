import 'package:eliud_core/model/dialog_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_pkg_apps/apps/shared/member/member_dashboard.dart';

import '../../app_base.dart';

class IncidamusMemberDashboard extends MemberDashboard {
  IncidamusMemberDashboard({InstallApp installApp, RgbModel backgroundColor}) :
        super(installApp, backgroundColor);
  Future<DialogModel> run() async {
    return super.run();
  }
}