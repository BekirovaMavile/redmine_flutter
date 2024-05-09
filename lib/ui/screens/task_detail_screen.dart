import 'package:flutter/material.dart';
import 'package:redmine_tasker/data/app_data.dart';
import 'package:redmine_tasker/data/taskDetail.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({required this.taskId});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool isWorking = false;
  bool isSubscribed = false;
  TaskDetail? taskDetail;

  @override
  Widget build(BuildContext context) {
    taskDetail = tasksDetails.firstWhere(
          (taskDetail) => taskDetail.taskId == widget.taskId,
      orElse: () => TaskDetail(
        taskId: '',
        name: '',
        status: '',
        priority: '',
        description: '',
        category: '',
        startDate: DateTime(2024, 1, 1),
        endDate: null,
        readinessPercentage: 0,
        fileList: [],
      ),
    );

    if (taskDetail != null) {
      return Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _workControlRow(),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    taskDetail!.name,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _statusAndPriority(taskDetail!.status, taskDetail!.priority),
              const Divider(),
              const SizedBox(height: 16.0),
              const Text(
                'Описание:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                taskDetail!.description,
                style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 19.0),
              _additionalInfo(
                taskDetail!.category,
                taskDetail!.startDate,
                taskDetail!.endDate,
                taskDetail!.readinessPercentage,
              ),
              const SizedBox(height: 4.0),
              const Text(
                'Файлы:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: taskDetail!.fileList.map((fileName) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      fileName,
                      style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: _appBar(context),
        body: Center(
          child: Text('Задача с ID ${widget.taskId} не найдена.'),
        ),
      );
    }
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF363636),
      title: const Row(
        children: [
          Icon(Icons.done_all, color: Colors.white),
          SizedBox(width: 6),
          Text('Redmine', style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text("№${widget.taskId}",
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }

  Widget _workControlRow() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF363636),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              if (!isSubscribed) {
                _showSubscriptionDialog();
              } else {
                setState(() {
                  isWorking = !isWorking;
                });
              }
            },
            child: Icon(isWorking ? Icons.pause : Icons.play_arrow, color: const Color(0xFF363636)),
          ),
          const SizedBox(width: 16.0),
          const Text(
            '00:00:00',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 21.0,
            ),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Для отслеживания времени подключите подписку."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Отмена", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFFF99A29)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Подключить",  style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  Widget _statusAndPriority(String? status, String? priority) {
    return Row(
      children: [
        const Text(
          'Статус: ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(status ?? 'Unknown', style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
        const Spacer(),
        const Text(
          'Приоритет: ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(priority ?? 'Unknown', style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
      ],
    );
  }

  Widget _additionalInfo(String? category, DateTime? startDate,
      DateTime? endDate, int readinessPercentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Категория: ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(category ?? 'Unknown', style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            const Text(
              'Дата начала: ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(startDate?.toString().split(' ')[0] ?? 'Unknown', style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            const Text(
              'Дата окончания: ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(endDate != null ? endDate.toString().split(' ')[0] : '-',
                style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            const Text(
              'Прогресс:   ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 30.0,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: readinessPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          bottomLeft: const Radius.circular(10.0),
                          topRight: readinessPercentage == 100 ? const Radius.circular(10.0) : Radius.zero,
                          bottomRight: readinessPercentage == 100 ? const Radius.circular(10.0) : Radius.zero,
                        ),
                        color: const Color(0xFFF99A29),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 100 - readinessPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    String newStatus = taskDetail!.status;
    String newPriority = taskDetail!.priority;
    DateTime newStartDate = taskDetail!.startDate;
    DateTime? newEndDate = taskDetail!.endDate;
    int newReadinessPercentage = taskDetail!.readinessPercentage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Редактировать задачу"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: taskDetail!.status,
                  onChanged: (value) {
                    newStatus = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Статус',
                  ),
                ),
                TextFormField(
                  initialValue: taskDetail!.priority,
                  onChanged: (value) {
                    newPriority = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Приоритет',
                  ),
                ),
                TextFormField(
                  initialValue: taskDetail!.startDate?.toString() ?? '',
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: newStartDate ?? DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null && picked != newStartDate) {
                      setState(() {
                        newStartDate = picked;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Дата начала',
                  ),
                ),
                TextFormField(
                  initialValue: taskDetail!.endDate?.toString() ?? '',
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: newEndDate ?? DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null && picked != newEndDate) {
                      setState(() {
                        newEndDate = picked;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Дата окончания',
                  ),
                ),
                Slider(
                  value: newReadinessPercentage.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: newReadinessPercentage.toString(),
                  onChanged: (double value) {
                    setState(() {
                      newReadinessPercentage = value.round();
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Отмена", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFFF99A29)),
              ),
              onPressed: () {
                setState(() {
                  taskDetail = TaskDetail(
                    taskId: taskDetail!.taskId,
                    name: taskDetail!.name,
                    status: newStatus,
                    priority: newPriority,
                    description: taskDetail!.description,
                    category: taskDetail!.category,
                    startDate: newStartDate,
                    endDate: newEndDate,
                    readinessPercentage: newReadinessPercentage,
                    fileList: taskDetail!.fileList,
                  );
                });
                Navigator.of(context).pop();
              },
              child: const Text("Сохранить",  style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

}
