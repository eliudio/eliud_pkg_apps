import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/about.dart';
import 'package:eliud_pkg_apps/apps/tools/tools.dart';
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
      description: "Hi guys, this is my first post and it's about a product in my shop. Lorem ipsum dolor sit amet consectetur adipiscing elit sed odio, maecenas luctus nam eget orci eleifend curae arcu euismod, potenti laoreet curabitur metus nibh aenean ultricies senectus. Ridiculus metus mus placerat facilisi turpis aenean id ultrices, per laoreet suspendisse maecenas est rutrum mollis mauris varius, a sapien nam venenatis sollicitudin mattis leo.",
      read: false,
    ));
    await AbstractRepositorySingleton.singleton.notificationRepository(MinkeyApp.MINKEY_APP_ID).add(NotificationModel(
      documentID: '2',
      appId:  MinkeyApp.MINKEY_APP_ID,
      description: "Another thing. This item when clicked should open the Minkey about box",
      action: GotoPage(MinkeyApp.MINKEY_APP_ID, pageID: AboutBase.identifier),
      read: false,
    ));
    await AbstractRepositorySingleton.singleton.notificationRepository(MinkeyApp.MINKEY_APP_ID).add(NotificationModel(
      documentID: '3',
      appId:  MinkeyApp.MINKEY_APP_ID,
      description: "And yet another thing",
      read: false,
    ));
  }
}
