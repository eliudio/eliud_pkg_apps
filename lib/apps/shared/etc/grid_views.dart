import 'package:eliud_model/model/abstract_repository_singleton.dart';
import 'package:eliud_model/model/grid_view_model.dart';

class GridViews {
  GridViewModel _gridView1(int id, String appId,  GridViewScrollDirection scrollDirection) {
    return GridViewModel(
      documentID: "$id",
      appId: appId,
      name: "Gridview $id: Count - 4 columns",
      type: GridViewGridType.Count,
      crossAxisCount: 4,
      childAspectRatio: 1,
      padding: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      scrollDirection: scrollDirection
    );
  }

  GridViewModel _gridView2(int id, String appId,  GridViewScrollDirection scrollDirection) {
    return GridViewModel(
      documentID: "$id",
      appId: appId,
      name: "Gridview $id: Extent - 150 pixels",
      type: GridViewGridType.Extent,
      maxCrossAxisExtentType: MaxCrossAxisExtentType.Absolute,
      absoluteMaxCrossAxisExtent: 150,
      childAspectRatio: 1,
      padding: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      scrollDirection: scrollDirection
    );
  }

  GridViewModel _gridView3(int id, String appId,  GridViewScrollDirection scrollDirection) {
    return GridViewModel(
      documentID: "$id",
      appId: appId,
      name: "Gridview $id: Extent - 30% of screen width " + _toString(scrollDirection),
      type: GridViewGridType.Extent,
      maxCrossAxisExtentType: MaxCrossAxisExtentType.Relative,
      relativeMaxCrossAxisExtent: .3,
      childAspectRatio: 1,
      padding: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      scrollDirection: scrollDirection
    );
  }

  String _toString(GridViewScrollDirection scrollDirection) => scrollDirection == GridViewScrollDirection.Vertical ? "Vertical" : "Horizontal";

  Future<GridViewModel> run(String appId) async {
    return await AbstractRepositorySingleton.singleton.gridViewRepository().add(_gridView1(1, appId, GridViewScrollDirection.Vertical))
        .then((_) async => await AbstractRepositorySingleton.singleton.gridViewRepository().add(_gridView2(2, appId, GridViewScrollDirection.Vertical)))
        .then((_) async => await AbstractRepositorySingleton.singleton.gridViewRepository().add(_gridView3(3, appId, GridViewScrollDirection.Vertical)))
        .then((_) async => await AbstractRepositorySingleton.singleton.gridViewRepository().add(_gridView1(4, appId, GridViewScrollDirection.Horizontal)))
        .then((_) async => await AbstractRepositorySingleton.singleton.gridViewRepository().add(_gridView2(5, appId, GridViewScrollDirection.Horizontal)))
        .then((_) async => await AbstractRepositorySingleton.singleton.gridViewRepository().add(_gridView3(6, appId, GridViewScrollDirection.Horizontal)));
    }
}
