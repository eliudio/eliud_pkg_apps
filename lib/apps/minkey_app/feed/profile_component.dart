import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

class ProfileComponent {
  final String appId;

  ProfileComponent(this.appId);

  static String PROFILE_ID = "profile";

  ProfileModel profileModel(FeedModel feed) {
    return ProfileModel(
      documentID: PROFILE_ID,
      appId: appId,
      feed: feed,
      description: "Profile",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<ProfileModel> createProfileModel(FeedModel feed) async {
    return await AbstractRepositorySingleton.singleton
        .profileRepository(appId)!
        .add(profileModel(feed));
  }

  Future<void> run(FeedModel feed) async {
    await createProfileModel(feed);
  }
}
