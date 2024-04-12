import 'package:best_way_tracker/assembly/entity/task_from_dto_factory.dart';
import 'package:best_way_tracker/assembly/factory.dart';
import 'package:best_way_tracker/assembly/model/task_dto_from_json_factory.dart';
import 'package:best_way_tracker/data/datasource/path_datasource.dart';
import 'package:best_way_tracker/data/datasource/task_datasource.dart';
import 'package:best_way_tracker/data/model/task_dto.dart';
import 'package:best_way_tracker/data/service/path_repository.dart';
import 'package:best_way_tracker/data/service/task_repository.dart';
import 'package:best_way_tracker/domain/entity/task.dart';
import 'package:best_way_tracker/domain/service/path_service.dart';
import 'package:best_way_tracker/domain/service/task_service.dart';
import 'package:best_way_tracker/presentation/bloc/path/path_cubit.dart';
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
    ..registerFactory<PathService>(
      () => PathRepository(sl.get()),
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
    ..registerLazySingleton<PathCubit>(
      () => PathCubit(sl.get()),
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
