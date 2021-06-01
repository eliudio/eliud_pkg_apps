import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

class HeaderComponent {
  final String appId;

  HeaderComponent(this.appId);

  static String HEADER_ID = "header";

  HeaderModel headerModel() {
    return HeaderModel(
      documentID: HEADER_ID,
      appId: appId,
      description: "Header",
      conditions: ConditionsSimpleModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple
      ),
    );
  }

  Future<HeaderModel> createHeaderModel() async {
    return await AbstractRepositorySingleton.singleton
        .headerRepository(appId)!
        .add(headerModel());
  }

  Future<void> run() async {
    await createHeaderModel();
  }
}
