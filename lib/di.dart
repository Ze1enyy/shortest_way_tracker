import 'package:best_way_tracker/assembly/entity/task_from_dto_factory.dart';
import 'package:best_way_tracker/assembly/factory.dart';
import 'package:best_way_tracker/assembly/model/task_dto_from_json_factory.dart';
import 'package:best_way_tracker/data/datasource/shortest_way_datasource.dart';
import 'package:best_way_tracker/data/datasource/task_datasource.dart';
import 'package:best_way_tracker/data/model/task_dto.dart';
import 'package:best_way_tracker/data/service/shortest_way_repository.dart';
import 'package:best_way_tracker/data/service/task_repository.dart';
import 'package:best_way_tracker/domain/entity/task.dart';
import 'package:best_way_tracker/domain/service/shortest_way_service.dart';
import 'package:best_way_tracker/domain/service/task_service.dart';
import 'package:best_way_tracker/presentation/bloc/shortest_way/shortest_way_cubit.dart';
import 'package:best_way_tracker/presentation/bloc/result/results_cubit.dart';
import 'package:best_way_tracker/presentation/bloc/task/task_cubit.dart';
import 'package:best_way_tracker/presentation/bloc/timer/timer_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void _registerFactories() {
  sl
    ..registerLazySingleton<Factory<Task, TaskDto>>(
      TaskFromDtoFactory.new,
    )
    ..registerLazySingleton<Factory<TaskDto, Map<String, dynamic>>>(
      TaskDtoFromJsonFactory.new,
    );
}

void _registerServices() {
  sl
    ..registerFactory<TaskService>(
      () => TaskRepository(sl.get()),
    )
    ..registerFactory<ShortestWayService>(
      () => ShortestWayRepository(sl.get()),
    );
}

void _registerDataSources() {
  sl
    ..registerFactory<ShortestWayDataSource>(
      ShortestWayDataSource.new,
    )
    ..registerFactory<TaskDataSource>(
      () => TaskDataSource(sl.get(), sl.get()),
    );
}

void _registerBlocs() {
  sl
    ..registerLazySingleton<ResultsCubit>(
      () => ResultsCubit(sl.get()),
    )
    ..registerLazySingleton<ShortestWayCubit>(
      () => ShortestWayCubit(sl.get()),
    )
    ..registerFactory<TimerCubit>(
      TimerCubit.new,
    )
    ..registerLazySingleton<TaskCubit>(
      () => TaskCubit(sl.get()),
    );
}

Future<void> init() async {
  _registerFactories();
  _registerDataSources();
  _registerServices();
  _registerBlocs();
}
