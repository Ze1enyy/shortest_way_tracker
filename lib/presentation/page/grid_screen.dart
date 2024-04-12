import 'package:best_way_tracker/di.dart';
import 'package:best_way_tracker/domain/entity/cell.dart';
import 'package:best_way_tracker/presentation/bloc/task/task_cubit.dart';
import 'package:best_way_tracker/utils/color_manager.dart';
import 'package:best_way_tracker/utils/field_parser.dart';
import 'package:flutter/material.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({required this.taskId, required this.path, super.key});
  final String taskId;
  final List<Cell> path;

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  final _taskCubit = sl<TaskCubit>();

  List<List<String>> grid = [];

  List<Cell> get path => widget.path;

  @override
  void initState() {
    super.initState();
    _taskCubit.state.whenOrNull(
      loaded: (tasks) {
        grid = tasks.firstWhere((element) => element.id == widget.taskId).grid;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: grid.isNotEmpty ? grid[0].length : 0,
            ),
            itemCount: grid.length * (grid.isNotEmpty ? grid[0].length : 0),
            itemBuilder: (context, index) {
              final row = index ~/ grid[0].length;
              final col = index % grid[0].length;
              final cellContent = grid[row][col];
              final isInPath =
                  path.any((cell) => cell.x == row && cell.y == col);

              return GridTile(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: ColorUtils.getCellColor(
                      cellContent: cellContent,
                      isInPath: isInPath,
                      path: path,
                      row: row,
                      col: col,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '($col,$row)',
                      style: TextStyle(
                        color: cellContent == 'X' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Text(
            FieldParser.stringify(path),
          ),
        ],
      ),
    );
  }
}
