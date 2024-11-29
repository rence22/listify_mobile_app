import 'package:flutter/material.dart';
import 'package:listify/shared_preference.dart'; // Import shared preferences
import 'login_page.dart'; // Import the login page
import 'addTask_page.dart';
import 'update_task_page.dart';
import 'package:intl/intl.dart';
import 'package:listify/models/todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> todoItems = [
    TodoItem(title: 'House Chores', time: '10:12', priority: 'Medium', dueDate: DateTime.now(), icon: Icons.home),
    TodoItem(title: 'Pay Tuition', time: '13:12', priority: 'High', dueDate: DateTime.now().add(const Duration(days: 1)), icon: Icons.school),
  ];

  List<TodoItem> completedItems = [];

  void markComplete(int index) {
    setState(() {
      completedItems.add(todoItems[index]);
      todoItems.removeAt(index);
    });
  }

  void deleteTask(int index, {bool isCompleted = false}) {
    setState(() {
      if (isCompleted) {
        completedItems.removeAt(index);
      } else {
        todoItems.removeAt(index);
      }
    });
  }

  Future<void> navigateToAddTaskPage() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    if (newTask != null) {
      setState(() {
        todoItems.add(newTask);
      });
    }
  }

  Future<void> navigateToUpdateTaskPage(int index) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateTaskPage(task: todoItems[index])),
    );

    if (updatedTask != null) {
      setState(() {
        todoItems[index] = updatedTask;
      });
    }
  }

  Future<void> logout() async {
    await saveUserData('', ''); // Clear user data in shared preferences
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Redirect to LoginPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: const Color(0xFF1B332D),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout, // Call the logout function
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: todoItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => navigateToUpdateTaskPage(index),
                        child: TodoItemWidget(
                          item: todoItems[index],
                          onCompleted: () => markComplete(index),
                          onDelete: () => deleteTask(index),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color.fromARGB(255, 117, 119, 119),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: navigateToAddTaskPage,
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              thickness: 1.5,
              color: Colors.grey,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              'Completed',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: completedItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      TodoItemWidget(
                        item: completedItems[index],
                        onCompleted: null,
                        onDelete: () => deleteTask(index, isCompleted: true),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xFFB0BEC5),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final VoidCallback? onCompleted;
  final VoidCallback? onDelete;

  const TodoItemWidget({
    super.key,
    required this.item,
    this.onCompleted,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(item.icon, color: const Color(0xFF1B332D)),
        title: Text(item.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.time),
            Text('Priority: ${item.priority}'),
            Text('Due Date: ${DateFormat.yMMMd().format(item.dueDate)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onCompleted != null)
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: onCompleted,
              ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 82, 79, 79)),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
