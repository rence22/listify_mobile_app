import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listify/models/todo_item.dart';

class UpdateTaskPage extends StatefulWidget {
  final TodoItem task; // Pass the task to be updated

  const UpdateTaskPage({super.key, required this.task});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late TextEditingController titleController;
  late TextEditingController timeController;
  String? selectedPriority;
  DateTime? dueDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    timeController = TextEditingController(text: widget.task.time);
    selectedPriority = widget.task.priority;
    dueDate = widget.task.dueDate;
  }

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
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
        backgroundColor: const Color(0xFF1B332D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            Container(
              margin: const EdgeInsets.only(bottom: 30.0, top: 30.0),
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
              margin: const EdgeInsets.only(bottom: 30.0),
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
              margin: const EdgeInsets.only(bottom: 30.0),
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
              margin: const EdgeInsets.only(bottom: 30.0),
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

            // Update Task Button
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  onPressed: () {
                    final updatedTask = TodoItem(
                      title: titleController.text,
                      time: timeController.text,
                      priority: selectedPriority!,
                      dueDate: dueDate!,
                      icon: Icons.task,
                    );
                    Navigator.pop(context, updatedTask);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B332D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Update Task',
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
