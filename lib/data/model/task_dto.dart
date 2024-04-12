class TaskDto {
  TaskDto({
    required this.id,
    required this.grid,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
  });
  final String id;
  final List<List<String>> grid;
  final int startX;
  final int startY;
  final int endX;
  final int endY;
}
