import 'package:best_way_tracker/assembly/factory.dart';
import 'package:best_way_tracker/data/model/task_dto.dart';
import 'package:best_way_tracker/domain/entity/task.dart';

class TaskFromDtoFactory implements Factory<Task, TaskDto> {
  @override
  Task create(TaskDto param) => Task(
        id: param.id,
        grid: param.grid,
        startX: param.startX,
        startY: param.startY,
        endX: param.endX,
        endY: param.endY,
      );
}
