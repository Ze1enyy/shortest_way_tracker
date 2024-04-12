part of 'shortest_way_cubit.dart';

@freezed
class ShortestWayState with _$ShortestWayState {
  const factory ShortestWayState.initial() = _Initial;
  const factory ShortestWayState.loaded(List<Solution> solutions) = _Loaded;
  const factory ShortestWayState.loading() = _Loading;
  const factory ShortestWayState.error(String error) = _Error;
}
