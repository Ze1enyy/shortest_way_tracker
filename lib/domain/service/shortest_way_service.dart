import 'package:best_way_tracker/domain/entity/cell.dart';

// ignore: one_member_abstracts
abstract interface class ShortestWayService {
  List<Cell> findShortestWay({
    required List<List<String>> grid,
    required int startX,
    required int startY,
    required int endX,
    required int endY,
  });
}
