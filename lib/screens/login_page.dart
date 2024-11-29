import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the home page
import 'signup_page.dart'; // Import the signup page
import '../shared_preference.dart'; // Import shared_preference.dart

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  // Retrieve saved data
  final userData = await getUserData();

  print('Login Attempt: Email=$email, Password=$password');
  print('Stored Data: ${userData.toString()}');

  if (userData['email']!.isEmpty || userData['password']!.isEmpty) {
    print('No user credentials found. Please sign up first.');
    _showErrorDialog('No user credentials found. Please sign up first.');
    return;
  }

  // Validate the email and password
  if (email == userData['email'] && password == userData['password']) {
    print('Login Successful');
    // Navigate to Home Page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TodoList()),
    );
  } else {
    print('Login Failed: Invalid email or password');
    _showErrorDialog('Invalid email or password');
  }
}
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),

                // Logo at the top
                Image.asset(
                  'assets/image/logo.png', // Path to your logo in assets folder
                  height: 250.0, // Adjust size as needed
                  width: 250.0,
                ),
                const SizedBox(height: 30.0),

                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20.0),

                // Password TextField
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30.0),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: const Color(0xFF1B332D), // Custom background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: const Text('Login'),
                  ),
                ),

                // Signup prompt
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text(
                    'Don’t have an account? Sign up',
                    style: TextStyle(color: Color(0xFF1B332D)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
