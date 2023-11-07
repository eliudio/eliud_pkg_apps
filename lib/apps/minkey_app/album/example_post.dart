import 'dart:async';

import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/platform_medium_helper.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';

import '../minkey_app.dart';

class ExampleAlbumHelper {
  final String memberId;

  ExampleAlbumHelper({
    required this.memberId,
  });

  Future<AlbumEntryModel> create(String path) async {
    return AlbumEntryModel(
        documentID: newRandomKey(),
        name: 'example 1',
        medium: await PlatformMediumHelper(MinkeyApp.app, memberId,
                PrivilegeLevelRequiredSimple.level1PrivilegeRequiredSimple)
            .createThumbnailUploadPhotoAsset(newRandomKey(), path));
  }

  Future<List<AlbumEntryModel>> createAll() async {
    return [
      await create(
          'packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
/*
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo1.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo2.jpg'),
    await create('packages/eliud_pkg_apps/assets/minkey_app/feed/example_photo3.jpg'),
*/
    ];
  }
}
