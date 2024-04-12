import 'package:best_way_tracker/data/datasource/shortest_way_datasource.dart';
import 'package:best_way_tracker/domain/entity/solution.dart';
import 'package:best_way_tracker/domain/entity/task.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shortest_way_state.dart';
part 'shortest_way_cubit.freezed.dart';

class ShortestWayCubit extends Cubit<ShortestWayState> {
  ShortestWayCubit(this._dataSource) : super(const ShortestWayState.initial());
  final ShortestWayDataSource _dataSource;

  Future<void> findShortestWay({
    required List<Task> tasks,
  }) async {
    final solutions = <Solution>[];
    emit(const _Loading());

    for (final task in tasks) {
      final path = _dataSource.findShortestWay(
        grid: task.grid,
        startX: task.startX,
        startY: task.startY,
        endX: task.endX,
        endY: task.endY,
      );
      if (path.isNotEmpty) {
        solutions.add(Solution(taskId: task.id, path: path));
      } else {
        emit(const _Error('No path found'));
      }
    }
    emit(_Loaded(solutions));
  }
}
