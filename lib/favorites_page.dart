import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static Set<String> _favorites = {};
  static late SharedPreferences _prefs;

  // This loads the data from the phone's storage
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? saved = _prefs.getStringList('favorites');
    _favorites = saved?.toSet() ?? {};
  }

  static bool isFavorite(String term) => _favorites.contains(term);

  static List<String> get allFavorites => _favorites.toList();

  static void toggle(String term) {
    if (_favorites.contains(term)) {
      _favorites.remove(term);
    } else {
      _favorites.add(term);
    }
    // Save to disk immediately
    _prefs.setStringList('favorites', _favorites.toList());
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the latest list every time the page builds
    final savedTerms = FavoritesManager.allFavorites;

    return Scaffold(
      appBar: AppBar(title: const Text("SAVED TERMS")),
      body: savedTerms.isEmpty
          ? const Center(child: Text("No favorites saved yet!"))
          : ListView.builder(
              itemCount: savedTerms.length,
              itemBuilder: (context, index) {
                final term = savedTerms[index];
                return ListTile(
                  title: Text(term, style: const TextStyle(color: Colors.amber)),
                  leading: const Icon(Icons.star, color: Colors.amber),
                );
              },
            ),
    );
  }
}