import 'package:flutter/material.dart';
import 'home_page.dart'; // The Tabbed Wiki
import 'favorites_page.dart'; // We'll create this next

class HomeScreen extends StatelessWidget {
  final Set<String> favorites; // We pass this through so we can show it

  const HomeScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("2XKO PORTAL")),
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