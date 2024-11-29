import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listify/models/todo_item.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String? selectedPriority;
  DateTime? dueDate;

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != dueDate) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color.fromARGB(255, 25, 52, 45),
        foregroundColor: Colors.white, // Arrow color changed to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            Container(
              margin: const EdgeInsets.only(bottom: 30.0, top: 30.0), // Added margin
              decoration: _boxDecoration(),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),

            // Task Time
            Container(
              margin: const EdgeInsets.only(bottom: 30.0), // Added margin
              decoration: _boxDecoration(),
              child: TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),

            // Priority Dropdown
            Container(
              margin: const EdgeInsets.only(bottom: 30.0), // Added margin
              decoration: _boxDecoration(),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
                value: selectedPriority,
                items: ['High', 'Medium', 'Low']
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value;
                  });
                },
              ),
            ),

            // Due Date Picker
            Container(
              margin: const EdgeInsets.only(bottom: 30.0), // Added margin
              decoration: _boxDecoration(),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: dueDate == null
                      ? 'Due Date'
                      : 'Due Date: ${DateFormat.yMMMd().format(dueDate!)}',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(12),
                ),
                onTap: () => _pickDueDate(context),
              ),
            ),

            // Add Task Button
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 40.0), // Margin added to the button
                child: ElevatedButton(
                  onPressed: () {
                    final title = titleController.text;
                    final time = timeController.text;

                    if (title.isNotEmpty &&
                        time.isNotEmpty &&
                        selectedPriority != null &&
                        dueDate != null) {
                      Navigator.pop(
                        context,
                        TodoItem(
                          title: title,
                          time: time,
                          priority: selectedPriority!,
                          dueDate: dueDate!,
                          icon: Icons.task,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B332D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Shadow decoration for containers
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
