import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_pkg_etc_model/model/member_action_model.dart';

class AppProfileAndFeedToAction {
  static List<MemberActionModel> getMemberActionModels(
      AppModel app, String? profilePageId, String? feedPageId) {
    List<MemberActionModel> memberActions = [];
    if (profilePageId != null) {
      memberActions.add(MemberActionModel(
          documentID: '1',
          text: 'Profile',
          description: "Open member's profile",
          action: GotoPage(app, pageID: profilePageId)));
    }
    if (feedPageId != null) {
      memberActions.add(MemberActionModel(
          documentID: '2',
          text: 'Feed',
          description: "Open member's feed",
          action: GotoPage(app, pageID: feedPageId)));
    }
    return memberActions;
  }
}
