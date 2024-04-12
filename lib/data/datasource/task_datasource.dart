import 'dart:convert';

import 'package:best_way_tracker/assembly/factory.dart';
import 'package:best_way_tracker/data/model/task_dto.dart';
import 'package:best_way_tracker/domain/entity/solution.dart';
import 'package:best_way_tracker/domain/entity/task.dart';
import 'package:best_way_tracker/utils/field_parser.dart';
import 'package:http/http.dart' as http;

class TaskDataSource {
  TaskDataSource(this._jsonFactory, this._dtoFactory);

  final Factory<TaskDto, Map<String, dynamic>> _jsonFactory;
  final Factory<Task, TaskDto> _dtoFactory;

  Future<List<Task>> fetchTasks(String url) async {
    try {
      final resp = await http.get(Uri.parse(url));
      final data = jsonDecode(resp.body);

      final tasks = <Task>[];

      for (final task in data['data'] as List<dynamic>) {
        final rows = <List<String>>[];

        for (final row
            in FieldParser.parseList(task['field'] as List<dynamic>)) {
          rows.add(row);
        }
        final dto = _jsonFactory
            .create({...task as Map<String, dynamic>, 'rows': rows});
        final parsedTask = _dtoFactory.create(dto);
        tasks.add(
          parsedTask,
        );
      }
      return tasks;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendAnswer(List<Solution> solutions, String url) async {
    try {
      await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          solutions
              .map(
                (solution) => {
                  'id': solution.taskId,
                  'result': {
                    'steps': solution.path
                        .map((cell) => {'x': '${cell.x}', 'y': '${cell.y}'})
                        .toList(),
                    'path': FieldParser.stringify(solution.path),
                  },
                },
              )
              .toList(),
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
