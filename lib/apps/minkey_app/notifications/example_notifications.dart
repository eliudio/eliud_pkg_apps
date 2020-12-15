import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/juuwle_app.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/product_page.dart';
import 'package:eliud_pkg_apps/apps/juuwle_app/shop/products.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/notification_model.dart';

import '../minkey_app.dart';

class ExampleNotifications {
  final Tools newAppTools;

  ExampleNotifications(this.newAppTools);

  Future<void> run() async {
    await AbstractRepositorySingleton.singleton.notificationRepository(MinkeyApp.MINKEY_APP_ID).add(NotificationModel(
        documentID: '1',
        appId:  MinkeyApp.MINKEY_APP_ID,
        description: "Hi guys, this is my first post and it's about a product in my shop",
    ));
  }
}
