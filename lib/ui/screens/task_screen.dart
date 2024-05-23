import 'package:flutter/material.dart';
import 'package:redmine_tasker/data/app_data.dart';
import 'package:redmine_tasker/data/task.dart';
import 'package:redmine_tasker/ui/screens/login_screen.dart';
import 'package:redmine_tasker/ui/screens/new_task_screen.dart';
import 'package:redmine_tasker/ui/screens/task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  bool isSorted = false;

  List<Task> get sortedTasks {
    List<Task> sorted = List.from(taskData);
    sorted.sort((a, b) {
      if (a.priority == b.priority) return 0;
      if (a.priority == 'Высокий') return -1;
      if (a.priority == 'Средний' && b.priority == 'Низкий') return -1;
      if (a.priority == 'Низкий') return 1;
      return 1;
    });
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _searchField(),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 11, right: 10),
            child: Row(
              children: [
                Text("Ваши последние задачи", style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _tableTask(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskScreen()),
          );
        },
        backgroundColor: Color(0xFFF99A29),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF363636),
      title: const Row(
        children: [
          Icon(Icons.done_all, color: Colors.white,),
          SizedBox(width: 6),
          Text('Redmine', style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.sort, color: Colors.white,),
          onPressed: () {
            setState(() {
              isSorted = !isSorted;
            });
          },
        ),
        Container(
          height: kToolbarHeight,
          decoration: const BoxDecoration(
            color: Color(0xFFF99A29),
            borderRadius: BorderRadius.zero,
          ),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 45,
            width: 315,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Task id',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFFF99A29)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Найти',
              style: TextStyle(
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableTask(BuildContext context) {
    List<Task> tasksToDisplay = isSorted ? sortedTasks : taskData;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Table(
        border: const TableBorder(
          horizontalInside: BorderSide(color: Colors.grey, width: 1.0),
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
            children: [
              _tableCell('ID'),
              _tableCell('Название'),
              _tableCell('Приоритет'),
            ],
          ),
          for (Task task in tasksToDisplay)
            TableRow(
              children: [
                GestureDetector(
                  onTap: () {
                    _navigateToTaskDetail(context, task.id);
                  },
                  child: _tableCell(task.id),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateToTaskDetail(context, task.id);
                  },
                  child: _tableCell(task.name),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateToTaskDetail(context, task.id);
                  },
                  child: _tableCell(task.priority),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 6.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
      ),
    );
  }

  void _navigateToTaskDetail(BuildContext context, String taskId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(taskId: taskId)),
    );
  }
}
