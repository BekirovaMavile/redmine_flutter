import 'package:flutter/material.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF363636),
        title: const Row(
          children: [
            Icon(Icons.done_all, color: Colors.white,),
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
              _buildTextField("Статус", initialValue: "новая", enabled: false),
              _buildCategoryDropdown(),
              Row(
                children: [
                  const Text(
                    "Файлы: "
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFF99A29),
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

  Widget _buildTrackerDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Трекер"),
        DropdownButton<String>(
          onChanged: (value) {
            // Обработка изменения выбора
          },
          items: <String>['defect', 'patch', 'feature'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Категория"),
        DropdownButton<String>(
          onChanged: (value) {
            // Обработка изменения выбора
          },
          items: <String>[
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
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
