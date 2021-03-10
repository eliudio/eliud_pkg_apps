
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/storage/asset_helper.dart';

class PolicyTools {
  static Future<PolicyModel> getPolicyFromHtml(String appId, String id, String name, String assetPath) async {
    var html = await AssetHelper.getContents(assetPath);
    var policyModel = PolicyModel(
      documentID: id,
      appId: appId,
      name: name,
      html: html,
    );
    await policyRepository(appId: appId).add(policyModel);
    return policyModel;
  }
}
