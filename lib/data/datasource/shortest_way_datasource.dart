import 'dart:collection';
import 'dart:math';

import 'package:best_way_tracker/domain/entity/cell.dart';

class ShortestWayDataSource {
  ShortestWayDataSource();

  List<List<Cell>> cells = [];
  // A* algorithm
  List<Cell> findShortestWay({
    required List<List<String>> grid,
    required int startX,
    required int startY,
    required int endX,
    required int endY,
  }) {
    cells.clear();
    final width = grid.length;
    final height = grid[0].length;

    for (var x = 0; x < width; x++) {
      cells.add([]);
      for (var y = 0; y < height; y++) {
        cells[x].add(Cell(x, y, isBlocked: grid[x][y] == 'X'));
      }
    }

    final startCell = cells[startX][startY];
    final endCell = cells[endX][endY];

    final openList = <Cell>[];
    final closedSet = HashSet<Cell>();

    openList.add(startCell);

    while (openList.isNotEmpty) {
      var currentCell = openList[0];
      for (final cell in openList) {
        if (cell.f < currentCell.f) {
          currentCell = cell;
        }
      }

      openList.remove(currentCell);
      closedSet.add(currentCell);

      if (currentCell == endCell) {
        return _getPath(startCell, endCell);
      }

      final neighbors = _getNeighbors(currentCell, width, height);

      for (final neighbor in neighbors) {
        if (closedSet.contains(neighbor) ||
            grid[neighbor.x][neighbor.y] == 'X') {
          continue;
        }

        final newG =
            currentCell.g + _calculateMovementCost(currentCell, neighbor);

        if (newG < neighbor.g || !openList.contains(neighbor)) {
          neighbor
            ..g = newG
            ..h = _calculateHeuristic(neighbor, endCell)
            ..f = neighbor.g + neighbor.h
            ..parent = currentCell;

          if (!openList.contains(neighbor)) {
            openList.add(neighbor);
          }
        }
      }
    }

    return [];
  }

  List<Cell> _getPath(Cell startCell, Cell endCell) {
    final path = <Cell>[];
    Cell? currentCell = endCell;

    while (currentCell != null && currentCell != startCell) {
      path.insert(0, currentCell);
      currentCell = currentCell.parent;
    }

    if (currentCell == startCell) {
      path.insert(0, startCell);
    }

    return path;
  }

  double _calculateHeuristic(Cell a, Cell b) {
    final dx = (a.x - b.x).abs().toDouble();
    final dy = (a.y - b.y).abs().toDouble();
    return dx > dy ? dx : dy;
  }

  double _calculateMovementCost(Cell currentCell, Cell neighbor) {
    final dx = (currentCell.x - neighbor.x).abs();
    final dy = (currentCell.y - neighbor.y).abs();

    return dx != 0 && dy != 0 ? sqrt(2) : 1;
  }

  List<Cell> _getNeighbors(Cell cell, int width, int height) {
    final neighbors = <Cell>[];
    final x = cell.x;
    final y = cell.y;

    if (x > 0) neighbors.add(cells[x - 1][y]);
    if (x < width - 1) neighbors.add(cells[x + 1][y]);
    if (y > 0) neighbors.add(cells[x][y - 1]);
    if (y < height - 1) neighbors.add(cells[x][y + 1]);

    if (x > 0 && y > 0) neighbors.add(cells[x - 1][y - 1]);
    if (x > 0 && y < height - 1) neighbors.add(cells[x - 1][y + 1]);
    if (x < width - 1 && y > 0) neighbors.add(cells[x + 1][y - 1]);
    if (x < width - 1 && y < height - 1) neighbors.add(cells[x + 1][y + 1]);

    return neighbors;
  }
}
