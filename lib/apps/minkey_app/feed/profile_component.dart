import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

import '../minkey_app.dart';

class ProfileComponent {
  ProfileComponent();

  static String profileId = "profile";

  ProfileModel profileModel(FeedModel feed) {
    return ProfileModel(
      documentID: profileId,
      appId: MinkeyApp.app.documentID,
      feed: feed,
      description: "Profile",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<ProfileModel> createProfileModel(FeedModel feed) async {
    return await AbstractRepositorySingleton.singleton
        .profileRepository(MinkeyApp.app.documentID)!
        .add(profileModel(feed));
  }

  Future<void> run(FeedModel feed) async {
    await createProfileModel(feed);
  }
}
