part of 'results_cubit.dart';

@freezed
class ResultsState with _$ResultsState {
  const factory ResultsState.initial() = _Initial;
  const factory ResultsState.loading() = _Loading;
  const factory ResultsState.loaded(Map<String, List<Cell>> solutions) =
      _Loaded;
  const factory ResultsState.error() = _Error;
}