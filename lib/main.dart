import 'package:flutter/material.dart';
import 'login_page.dart';
import 'favorites_page.dart';

Set<String> globalFavorites = {};

void main() async {
  // Ensure Flutter is ready
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize your manager here so it loads data from disk
  await FavoritesManager.init();
  
  runApp(const TwoXKOWikiApp());
}

class TwoXKOWikiApp extends StatelessWidget {
  const TwoXKOWikiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2XKO Terminal Portal',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.cyanAccent,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A1A1A)),
      ),
      // The Entry Point is now the Login Page
      home: LoginPage(), 
    );
  }
}