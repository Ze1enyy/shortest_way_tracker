import 'package:best_way_tracker/domain/entity/solution.dart';
import 'package:best_way_tracker/domain/entity/task.dart';

abstract class TaskService {
  Future<List<Task>> fetchTasks(String url);
  Future<dynamic> sendAnswer(List<Solution> solutions, String url);
}
