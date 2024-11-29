import 'package:flutter/material.dart';
import 'home_page.dart';
import '../shared_preference.dart'; // Import shared_preference.dart

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signUp() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isNotEmpty && password.isNotEmpty) {
    // Save the user's email and password
    await saveUserData(email, password);

    // Verify if the email is saved correctly
    final userData = await getUserData();
    print('Signup Successful: $userData'); // Debugging

    if (userData['email'] == email) {
      // Navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TodoList()),
      );
    } else {
      _showErrorDialog('Signup Failed', 'Failed to save user data. Please try again.');
    }
  } else {
    _showErrorDialog('Signup Failed', 'Please enter a valid email and password.');
  }
}


void _showErrorDialog(String title, String content) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: const Color(0xFF1B332D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView( // Added for better layout on smaller screens
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                const SizedBox(height: 20.0),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: const Color(0xFF1B332D),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
