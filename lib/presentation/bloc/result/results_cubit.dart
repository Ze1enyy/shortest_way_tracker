import 'package:best_way_tracker/domain/entity/solution.dart';
import 'package:best_way_tracker/domain/service/task_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'results_state.dart';
part 'results_cubit.freezed.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(this._taskService) : super(const ResultsState.initial());
  final TaskService _taskService;

  Future<void> sendAnswer(List<Solution> solutions, String url) async {
    try {
      emit(const _Loading());
      await _taskService.sendAnswer(solutions, url);
      emit(_Loaded(solutions));
    } catch (e) {
      emit(_Error(e));
    }
  }
}
