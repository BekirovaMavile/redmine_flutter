import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  String dropdownvalueTracker = 'Defect';
  String dropdownvalueCategory = 'Code cleanup/refactoring';
  String dropdownvalueStatus = 'Новая';
  String selectedFilePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF363636),
        title: const Row(
          children: [
            Icon(Icons.done_all, color: Colors.white),
            SizedBox(width: 6),
            Text('Redmine', style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Проект"),
              _buildTrackerDropdown(),
              _buildTextField("Описание", maxLines: 5),
              _buildStatusDropdown(),
              _buildCategoryDropdown(),
              Row(
                children: [
                  Text("Файлы: $selectedFilePath"),
                  ElevatedButton(
                    onPressed: () async {
                      String? filePath = await _selectFile();
                      if (filePath != null) {
                        setState(() {
                          selectedFilePath = filePath!;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF99A29),
                    ),
                    child: const Text(
                      "Выбрать файлы",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: const Color(0xFFF99A29),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int? maxLines, String? initialValue, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(
          height: 45,
          child: TextFormField(
            // cursorColor: Colors.orange,
            initialValue: initialValue,
            maxLines: maxLines ?? 1,
            enabled: enabled,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    var items = ['Новая', 'Повторная'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Статус"),
        DropdownButton(
          value: dropdownvalueStatus,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalueStatus = newValue!;
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTrackerDropdown() {
    var items = ['Defect', 'Patch', 'Feature'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Трекер"),
        DropdownButton(
          value: dropdownvalueTracker,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalueTracker = newValue!;
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    var items = [
      'Accounts / authentication',
      'Administration',
      'Calendar',
      'Code cleanup/refactoring',
      'Database',
      'Documentation',
      'Email notifications',
      'Filters',
      'Forums',
      'Gantt',
      'News',
      'Project settings',
      'REST API',
      'Roadmap',
      'SEO',
      'Text formatting',
      'Themes',
      'UI'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Категория"),
        DropdownButton(
          value: dropdownvalueCategory,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalueCategory = newValue!;
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<String?> _selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        return file.path;
      } else {
        return null;
      }
    } catch (e) {
      print('Error selecting file: $e');
      return null;
    }
  }
}

