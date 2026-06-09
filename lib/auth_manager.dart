import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  static Future<String?> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Check if user already exists
    if (prefs.containsKey(username)) {
      return "Username already taken!";
    }

    // Save user with hashed password
    await prefs.setString(username, hashPassword(password));
    return null; // Null means success
  }

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedHash = prefs.getString(username);
    
    if (storedHash == null) return false; // User not found
    return storedHash == hashPassword(password);
  }
}