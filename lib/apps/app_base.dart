import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/components/page_constructors/eliud_appbar.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/style/frontend/has_drawer.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/admin_app_base.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_create/tools/defaults.dart' as defaults;
import 'package:eliud_pkg_apps/apps/shared/admin/admin.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/colors.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/grid_views.dart';
import 'package:eliud_pkg_apps/apps/shared/etc/menu_items_helper_consts.dart';
import 'package:eliud_pkg_apps/apps/shared/policies/policy_page.dart';
import 'package:eliud_pkg_apps/apps/tools/image_tools.dart';
import 'package:eliud_pkg_fundamentals/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_fundamentals/model/divider_model.dart';
import 'package:eliud_pkg_create/tools/new_app_functions.dart';
import 'package:flutter/material.dart';

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
      print('Can not register $theApp.documentID because member cannot be created');
    } else {
      memberClaimRepository()!.listenTo(member!.documentID, (value) async {
        await usr.reload();
        var idTokenResult = await usr.getIdTokenResult(true);
      });

      await claimAccess(theApp.documentID, usr.uid);

      await run(usr.uid);
      print('Installed $theApp.documentID successfully');
    }
  }

  // Implementation
  Future<void> run(String ownerID);
}
