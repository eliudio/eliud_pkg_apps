import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_create/tools/new_app_functions.dart';

abstract class AppBase {
  final AppModel theApp;
  MemberModel? member;

  AppBase(this.theApp);

  Future<void> wipeAndReinstall() async {
    // If I would be logged in > logout (to give the user opportunity to select the user in the signIn)
    await AbstractMainRepositorySingleton.singleton.userRepository()!.signOut();
    var usr = await (AbstractMainRepositorySingleton.singleton
        .userRepository()!
        .signInWithGoogle());
    if (usr == null) {
      throw Exception("User is null");
    }
    await claimOwnerShipApplication(theApp.documentID, usr.uid);

    member = await AccessBloc.firebaseToMemberModel(usr);
    if (member == null) {
      print(
          'Can not register $theApp.documentID because member cannot be created');
    } else {
      memberClaimRepository()!.listenTo(member!.documentID, (value) async {
        await usr.reload();
        await usr.getIdTokenResult(true);
      });

      await claimAccess(theApp.documentID, usr.uid);

      await run(usr.uid);
      print('Installed $theApp.documentID successfully');
    }
  }

  // Implementation
  Future<void> run(String ownerID);
}
