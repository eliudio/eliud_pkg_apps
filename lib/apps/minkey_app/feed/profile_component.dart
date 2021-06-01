import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

class ProfileComponent {
  final String appId;

  ProfileComponent(this.appId);

  static String PROFILE_ID = "profile";

  ProfileModel profileModel() {
    return ProfileModel(
      documentID: PROFILE_ID,
      appId: appId,
      description: "Profile",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<ProfileModel> createProfileModel() async {
    return await AbstractRepositorySingleton.singleton
        .profileRepository(appId)!
        .add(profileModel());
  }

  Future<void> run() async {
    await createProfileModel();
  }
}
