part of 'results_cubit.dart';

@freezed
class ResultsState with _$ResultsState {
  const factory ResultsState.initial() = _Initial;
  const factory ResultsState.loading() = _Loading;
  const factory ResultsState.loaded(List<Solution> solutions) = _Loaded;
  const factory ResultsState.error(Object? error) = _Error;
}
