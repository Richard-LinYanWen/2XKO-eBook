import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Required for JSON
import 'background_pattern.dart';
import 'terminology_detail.dart';

class FavoritesManager {
  // FIXED: Changed Set to Map
  static Map<String, String> _favorites = {};
  static late SharedPreferences _prefs;
  static String? _currentUserId;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> loadFavoritesForUser(String userId) async {
    _currentUserId = userId;
    final key = _getPrefKey();

    // 1. Get the raw object (returns Object? instead of specifically String)
    final Object? rawData = _prefs.get(key);

    if (rawData is String) {
      // 2. If it's a String, it's our new JSON format
      try {
        _favorites = Map<String, String>.from(jsonDecode(rawData));
      } catch (e) {
        debugPrint("Error decoding favorites JSON: $e");
        _favorites = {};
      }
    } else {
      // 3. If it's null, or a List<String> (old format), treat it as empty
      // and remove the corrupted/old data entry.
      _favorites = {};
      await _prefs.remove(key); 
    }
  }

  static String _getPrefKey() {
    return 'favorites_${_currentUserId ?? 'guest'}';
  }

  // FIXED: Changed contains to containsKey
  static bool isFavorite(String term) => _favorites.containsKey(term);

  static String getDefinition(String term) => _favorites[term] ?? "";

  static Map<String, String> get allFavorites => _favorites;

  static void toggle(String term, String definition) {
    if (_favorites.containsKey(term)) {
      _favorites.remove(term);
    } else {
      _favorites[term] = definition;
    }
    // Save as JSON string
    _prefs.setString(_getPrefKey(), jsonEncode(_favorites));
  }

  static void clear() {
    _currentUserId = null;
    _favorites = {};
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final savedTerms = FavoritesManager.allFavorites;

    return BackgroundPattern(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("SAVED TERMS"),
          backgroundColor: Colors.transparent,
        ),
        body: savedTerms.isEmpty
            ? const Center(
                child: Text("No favorites saved yet!", style: TextStyle(color: Colors.white70)),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: savedTerms.length,
                itemBuilder: (context, index) {
                  final term = savedTerms.keys.elementAt(index);
                  final definition = savedTerms.values.elementAt(index);
                  
                  return Card(
                    // Matching your other pages' card style
                    color: Colors.white.withValues(alpha: 0.05),
                    child: ListTile(
                      title: Text(
                        term, 
                        style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                      ),
                      leading: const Icon(Icons.star, color: Colors.amber),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TerminologyDetail(
                              term: term, 
                              definition: definition,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}