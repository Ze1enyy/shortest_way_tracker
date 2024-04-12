part of 'path_cubit.dart';

@freezed
class PathState with _$PathState {
  const factory PathState.initial() = _Initial;
  const factory PathState.loaded(Map<String, List<Cell>> solutions) = _Loaded;
  const factory PathState.loading() = _Loading;
  const factory PathState.error(String error) = _Error;
}
