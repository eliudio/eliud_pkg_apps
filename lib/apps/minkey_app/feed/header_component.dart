import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

class HeaderComponent {
  final String appId;

  HeaderComponent(this.appId);

  static String HEADER_ID = "header";

  HeaderModel headerModel(FeedModel feed) {
    return HeaderModel(
      documentID: HEADER_ID,
      feed: feed,
      appId: appId,
      description: "Header",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<HeaderModel> createHeaderModel(FeedModel feed) async {
    return await AbstractRepositorySingleton.singleton
        .headerRepository(appId)!
        .add(headerModel(feed));
  }

  Future<void> run(FeedModel feed) async {
    await createHeaderModel(feed);
  }
}
