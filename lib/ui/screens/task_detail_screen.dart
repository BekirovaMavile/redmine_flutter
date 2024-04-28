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

  @override
  Widget build(BuildContext context) {
    TaskDetail? taskDetail = tasksDetails.firstWhere(
          (taskDetail) => taskDetail.taskId == widget.taskId,
      orElse: () =>
          TaskDetail(
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
              const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      taskDetail.name,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
              const SizedBox(height: 16.0),
              _statusAndPriority(taskDetail.status, taskDetail.priority),
              Divider(),
              const SizedBox(height: 16.0),
              const Text(
                'Описание:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                taskDetail.description,
                style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 19.0),
              _additionalInfo(
                  taskDetail.category, taskDetail.startDate, taskDetail.endDate,
                  taskDetail.readinessPercentage),
              const SizedBox(height: 4.0),
              const Text(
                'Файлы:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: taskDetail.fileList.map((fileName) {
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
              setState(() {
                isWorking = !isWorking;
              });
            },
            child: Icon(isWorking ? Icons.pause : Icons.play_arrow, color: Color(0xFF363636)),
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


  Widget _statusAndPriority(String? status, String? priority) {
    return Row(
      children: [
        const Text(
          'Статус: ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(status ?? 'Unknown', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
        const Spacer(),
        const Text(
          'Приоритет: ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(priority ?? 'Unknown', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
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
            Text(category ?? 'Unknown', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            const Text(
              'Дата начала: ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(startDate?.toString().split(' ')[0] ?? 'Unknown', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
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
                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)
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
                        color: Colors.orange,
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
}