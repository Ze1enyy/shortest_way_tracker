import 'package:best_way_tracker/data/datasource/shortest_way_datasource.dart';
import 'package:best_way_tracker/domain/entity/cell.dart';
import 'package:best_way_tracker/domain/service/path_service.dart';

class PathRepository implements PathService {
  PathRepository(this._dataSource);

  final ShortestWayDataSource _dataSource;
  @override
  List<Cell> findShortestWay({
    required List<List<String>> grid,
    required int startX,
    required int startY,
    required int endX,
    required int endY,
  }) {
    return _dataSource.findShortestWay(
      grid: grid,
      startX: startX,
      startY: startY,
      endX: endX,
      endY: endY,
    );
  }
}
