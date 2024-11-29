import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoItem {
  final String title;
  final String time;
  final String priority;
  final DateTime dueDate;
  final IconData icon;

  TodoItem({
    required this.title,
    required this.time,
    required this.priority,
    required this.dueDate,
    required this.icon,
  });

  // Getter to format due date
  String get dueDateFormatted => DateFormat.yMMMd().format(dueDate);
}
