/*
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';

import '../minkey_app.dart';

class HeaderComponent {
  HeaderComponent();

  static String HEADER_ID = "header";

  HeaderModel headerModel(FeedModel feed) {
    return HeaderModel(
      documentID: HEADER_ID,
      feed: feed,
      appId: MinkeyApp.app.documentID,
      description: "Header",
      conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple
      ),
    );
  }

  Future<HeaderModel> createHeaderModel(FeedModel feed) async {
    return await AbstractRepositorySingleton.singleton
        .headerRepository(MinkeyApp.app.documentID)!
        .add(headerModel(feed));
  }

  Future<void> run(FeedModel feed) async {
    await createHeaderModel(feed);
  }
}
*/
