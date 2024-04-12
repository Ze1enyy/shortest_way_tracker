class Cell {
  Cell(
    this.x,
    this.y, {
    required this.isBlocked,
  }) {
    f = 0;
    g = 0;
    h = 0;
  }
  final int x;
  final int y;
  final bool isBlocked;
  late double f;
  late double g;
  late double h;

  Cell? parent;
}
