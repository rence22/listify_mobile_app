import 'package:flutter/material.dart';
import 'package:listify/models/todo_item.dart';
import 'package:listify/utils/constants.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(item.icon, color: AppColors.primaryColor),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: ${item.time}'),
            Text('Priority: ${item.priority}', style: TextStyle(color: getPriorityColor(item.priority))),
            Text('Due: ${item.dueDateFormatted}'),
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
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
