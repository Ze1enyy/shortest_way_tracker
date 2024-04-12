import 'package:best_way_tracker/domain/entity/task.dart';
import 'package:best_way_tracker/domain/service/task_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_state.dart';
part 'task_cubit.freezed.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(
    this._taskService,
  ) : super(const TaskState.initial());
  final TaskService _taskService;

  Future<void> fetchTasks(String url) async {
    try {
      emit(const _Loading());
      final tasks = await _taskService.fetchTasks(url);
      emit(
        _Loaded(tasks),
      );
    } catch (e) {
      emit(_Error(e));
    }
  }
}
