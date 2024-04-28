class TaskDetail {
  final String taskId;
  final String name;
  final String category;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final String priority;
  final int readinessPercentage;
  final List<String> fileList;

  TaskDetail({
    required this.taskId,
    required this.name,
    required this.category,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.priority,
    required this.readinessPercentage,
    required this.fileList,
    required this.status,
  });
}