import 'package:eliud_core_main/model/abstract_repository_singleton.dart';
import 'package:eliud_core_main/model/grid_view_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';

class GridViews {
  GridViewModel _gridView1(
      int id, String appId, GridViewScrollDirection scrollDirection) {
    return GridViewModel(
      documentID: "$id",
      appId: appId,
      name: "Gridview $id: Count - 4 columns",
      type: GridViewGridType.count,
      crossAxisCount: 4,
      childAspectRatio: 1,
      padding: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      scrollDirection: scrollDirection,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  GridViewModel _gridView2(
      int id, String appId, GridViewScrollDirection scrollDirection) {
    return GridViewModel(
      documentID: "$id",
      appId: appId,
      name: "Gridview $id: Extent - 150 pixels",
      type: GridViewGridType.extent,
      maxCrossAxisExtentType: MaxCrossAxisExtentType.absolute,
      absoluteMaxCrossAxisExtent: 150,
      childAspectRatio: 1,
      padding: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      scrollDirection: scrollDirection,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  GridViewModel _gridView3(
      int id, String appId, GridViewScrollDirection scrollDirection) {
    return GridViewModel(
      documentID: "$id",
      appId: appId,
      name:
          "Gridview $id: Extent - 30% of screen width ${_toString(scrollDirection)}",
      type: GridViewGridType.extent,
      maxCrossAxisExtentType: MaxCrossAxisExtentType.relative,
      relativeMaxCrossAxisExtent: .3,
      childAspectRatio: 1,
      padding: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      scrollDirection: scrollDirection,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  String _toString(GridViewScrollDirection scrollDirection) =>
      scrollDirection == GridViewScrollDirection.vertical
          ? "Vertical"
          : "Horizontal";

  Future<void> run(String appId) async {
    await AbstractRepositorySingleton.singleton
        .gridViewRepository(appId)!
        .add(_gridView1(1, appId, GridViewScrollDirection.vertical));
    await AbstractRepositorySingleton.singleton
        .gridViewRepository(appId)!
        .add(_gridView2(2, appId, GridViewScrollDirection.vertical));
    await AbstractRepositorySingleton.singleton
        .gridViewRepository(appId)!
        .add(_gridView3(3, appId, GridViewScrollDirection.vertical));
    await AbstractRepositorySingleton.singleton
        .gridViewRepository(appId)!
        .add(_gridView1(4, appId, GridViewScrollDirection.horizontal));
    await AbstractRepositorySingleton.singleton
        .gridViewRepository(appId)!
        .add(_gridView2(5, appId, GridViewScrollDirection.horizontal));
    await AbstractRepositorySingleton.singleton
        .gridViewRepository(appId)!
        .add(_gridView3(6, appId, GridViewScrollDirection.horizontal));
  }
}
