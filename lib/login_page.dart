import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import this to navigate to the home screen
import 'home_page.dart'; // Import the new home page file

class LoginPage extends StatelessWidget {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  LoginPage({super.key});

  void _login(BuildContext context) {
    // Basic mock check
    if (_userController.text == 'admin' && _passController.text == '1234') {
      
      // 2. Navigate to the new HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(favorites: {}), // Pass an empty set initially
        ),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Username')),
          TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          ElevatedButton(onPressed: () => _login(context), child: const Text('Login')),
        ],
      ),
    );
  }
}