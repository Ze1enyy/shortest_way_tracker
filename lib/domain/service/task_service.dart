import 'package:best_way_tracker/domain/entity/cell.dart';
import 'package:best_way_tracker/domain/entity/task.dart';

abstract class TaskService {
  Future<List<Task>> fetchTasks(String url);
  Future<dynamic> sendAnswer(Map<String, List<Cell>> solutions, String url);
}
