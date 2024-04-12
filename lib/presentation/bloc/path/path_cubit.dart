import 'package:best_way_tracker/data/datasource/shortest_way_datasource.dart';
import 'package:best_way_tracker/domain/entity/cell.dart';
import 'package:best_way_tracker/domain/entity/task.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'path_state.dart';
part 'path_cubit.freezed.dart';

class PathCubit extends Cubit<PathState> {
  PathCubit(this._dataSource) : super(const PathState.initial());
  final ShortestWayDataSource _dataSource;

  Future<void> findShortestWay({
    required List<Task> tasks,
  }) async {
    emit(const _Loading());
    final solutions = <String, List<Cell>>{};
    for (final task in tasks) {
      final path = _dataSource.findShortestWay(
        grid: task.grid,
        startX: task.startX,
        startY: task.startY,
        endX: task.endX,
        endY: task.endY,
      );
      if (path.isNotEmpty) {
        solutions.addEntries({MapEntry(task.id, path)});
      } else {
        emit(const _Error('No path found'));
      }
    }
    emit(_Loaded(solutions));
  }
}
