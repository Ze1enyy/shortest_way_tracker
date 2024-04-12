import 'package:best_way_tracker/domain/entity/cell.dart';

class FieldParser {
  static List<List<String>> parseList(List<dynamic> field) {
    final cells = <List<String>>[];
    for (var i = 0; i < field.length; i++) {
      final split = (field[i] as String).split('\n');
      for (var j = 0; j < split.length; j++) {
        final row = <String>[];
        for (final cell in split[j].split('')) {
          row.add(cell);
        }
        cells.add(row);
      }
    }
    return cells;
  }

  static String stringify(List<Cell> cells) {
    return cells.map((cell) => '(${cell.x},${cell.y})').join('->');
  }
}
