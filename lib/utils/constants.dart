// lib/utils/constants.dart

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF5E58D6);
  static const Color highPriorityColor = Colors.red;
  static const Color mediumPriorityColor = Colors.orange;
  static const Color lowPriorityColor = Colors.green;
}

class AppTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );
}
