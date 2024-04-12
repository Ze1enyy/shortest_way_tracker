import 'package:best_way_tracker/domain/entity/cell.dart';
import 'package:best_way_tracker/domain/service/task_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'results_state.dart';
part 'results_cubit.freezed.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(this._taskService) : super(const ResultsState.initial());
  final TaskService _taskService;

  Future<void> sendAnswer(Map<String, List<Cell>> solutions, String url) async {
    emit(const _Loading());
    await _taskService.sendAnswer(solutions, url);
    emit(_Loaded(solutions));
  }
}
