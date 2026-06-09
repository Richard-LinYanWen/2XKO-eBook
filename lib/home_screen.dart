import 'package:flutter/material.dart';
import 'home_page.dart'; // The Tabbed Wiki
import 'favorites_page.dart';
import 'login_page.dart'; // To navigate back to login
import 'background_pattern.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundPattern(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Let the pattern show through
        appBar: AppBar(
          title: const Text("2XKO PORTAL"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FavoritesManager.clear(); 
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildMenuCard(
              context,
              title: "WIKI",
              icon: Icons.menu_book,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage())),
            ),
            _buildMenuCard(
              context,
              title: "SAVED",
              icon: Icons.favorite,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesPage())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(icon, size: 50, color: Colors.cyanAccent), Text(title, style: const TextStyle(fontSize: 24))],
            ),
          ),
        ),
      ),
    );
  }
}