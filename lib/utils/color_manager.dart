import 'package:best_way_tracker/domain/entity/cell.dart';
import 'package:best_way_tracker/presentation/palette.dart';
import 'package:flutter/material.dart';

class ColorUtils {
  static Color getCellColor({
    required String cellContent,
    required bool isInPath,
    required List<Cell> path,
    required int row,
    required int col,
  }) {
    return cellContent == 'X'
        ? Palette.blockedColor
        : isInPath
            ? (row == path.first.x && col == path.first.y)
                ? Palette.startColor
                : (row == path.last.x && col == path.last.y)
                    ? Palette.destinationColor
                    : Palette.shortestWayColor
            : Colors.transparent;
  }
}
