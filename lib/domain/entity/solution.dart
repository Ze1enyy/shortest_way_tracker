import 'package:best_way_tracker/domain/entity/cell.dart';

class Solution {
  Solution({required this.taskId, required this.path});

  final String taskId;
  final List<Cell> path;
}
