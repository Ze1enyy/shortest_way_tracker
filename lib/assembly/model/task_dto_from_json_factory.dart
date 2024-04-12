import 'package:best_way_tracker/assembly/factory.dart';
import 'package:best_way_tracker/data/model/task_dto.dart';

class TaskDtoFromJsonFactory implements Factory<TaskDto, Map<String, dynamic>> {
  @override
  TaskDto create(Map<String, dynamic> param) => TaskDto(
        id: param['id'] as String,
        grid: param['rows'] as List<List<String>>,
        startX: param['start']['x'] as int,
        startY: param['start']['y'] as int,
        endX: param['end']['x'] as int,
        endY: param['end']['y'] as int,
      );
}
