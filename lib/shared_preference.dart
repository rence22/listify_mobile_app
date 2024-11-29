import 'package:shared_preferences/shared_preferences.dart';

// Save user's email and password
Future<void> saveUserData(String email, String password) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  await prefs.setString('password', password);

  // Debugging output
  print('Saved Email: ${prefs.getString('email')}');
  print('Saved Password: ${prefs.getString('password')}');
}

// Retrieve user data (email and password)
Future<Map<String, String?>> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  final password = prefs.getString('password');

  // Debugging output
  print('Retrieved Email: $email');
  print('Retrieved Password: $password');

  return {'email': email, 'password': password};
}

// Clear all user data
Future<void> clearUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  print('User data cleared');
}
