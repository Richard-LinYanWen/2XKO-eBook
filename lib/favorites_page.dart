import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background_pattern.dart';

class FavoritesManager {
  static Set<String> _favorites = {};
  static late SharedPreferences _prefs;
  static String? _currentUserId;

  // Initialize SharedPreferences only once at startup
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // CALL THIS after a successful login to load that specific user's data
  static Future<void> loadFavoritesForUser(String userId) async {
    _currentUserId = userId;
    final List<String>? saved = _prefs.getStringList(_getPrefKey());
    _favorites = saved?.toSet() ?? {};
  }

  // Helper to generate the unique key (e.g., "favorites_user123")
  static String _getPrefKey() {
    return 'favorites_${_currentUserId ?? 'guest'}';
  }

  static bool isFavorite(String term) => _favorites.contains(term);

  static List<String> get allFavorites => _favorites.toList();

  static void toggle(String term) {
    if (_favorites.contains(term)) {
      _favorites.remove(term);
    } else {
      _favorites.add(term);
    }
    // Save to disk using the specific user's key
    _prefs.setStringList(_getPrefKey(), _favorites.toList());
  }

  // CALL THIS on logout to prevent data leaking to the next user
  static void clear() {
    _currentUserId = null;
    _favorites = {};
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the latest list every time the page builds
    final savedTerms = FavoritesManager.allFavorites;

    return BackgroundPattern(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Let the pattern show through
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
      ),
    );
  }
}