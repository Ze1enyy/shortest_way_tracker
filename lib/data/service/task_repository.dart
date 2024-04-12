import 'package:best_way_tracker/data/datasource/task_datasource.dart';
import 'package:best_way_tracker/domain/entity/cell.dart';
import 'package:best_way_tracker/domain/entity/task.dart';
import 'package:best_way_tracker/domain/service/task_service.dart';

class TaskRepository implements TaskService {
  TaskRepository(this._dataSource);

  final TaskDataSource _dataSource;
  @override
  Future<List<Task>> fetchTasks(String url) {
    return _dataSource.fetchTasks(url);
  }

  @override
  Future<dynamic> sendAnswer(Map<String, List<Cell>> solutions, String url) {
    return _dataSource.sendAnswer(solutions, url);
  }
}
