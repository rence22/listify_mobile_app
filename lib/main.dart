import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart'; // Ensure this import is correct
import 'shared_preference.dart'; // Import shared preference utility

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Retrieve saved user data
  final userData = await getUserData();
  print('App Start: User Data=$userData'); // Debugging

  final bool isLoggedIn = userData['email']?.isNotEmpty == true;

  runApp(MyApp(initialScreen: isLoggedIn ? const TodoList() : const LoginPage()));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialScreen,
    );
  }
}
