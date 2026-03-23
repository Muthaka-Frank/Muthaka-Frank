import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  static const String _usersKey = 'auth.users';
  static const String _currentUserKey = 'auth.currentUser';

  final Map<String, String> _emailToPasswordHash = <String, String>{};
  String? _currentUserEmail;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  bool get isAuthenticated => _currentUserEmail != null;
  String? get currentUserEmail => _currentUserEmail;

  Future<void> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_usersKey);
    if (usersJson != null && usersJson.isNotEmpty) {
      final Map<String, dynamic> decoded = jsonDecode(usersJson) as Map<String, dynamic>;
      decoded.forEach((String email, dynamic hash) {
        if (hash is String) {
          _emailToPasswordHash[email] = hash;
        }
      });
    }
    _currentUserEmail = prefs.getString(_currentUserKey);
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> signUp({required String email, required String password}) async {
    final String normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      throw Exception('Please enter a valid email.');
    }
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters.');
    }
    if (_emailToPasswordHash.containsKey(normalizedEmail)) {
      throw Exception('An account with this email already exists.');
    }
    final String hash = _hashPassword(password);
    _emailToPasswordHash[normalizedEmail] = hash;
    _currentUserEmail = normalizedEmail;
    await _persist();
    notifyListeners();
  }

  Future<void> signIn({required String email, required String password}) async {
    final String normalizedEmail = email.trim().toLowerCase();
    final String? existingHash = _emailToPasswordHash[normalizedEmail];
    if (existingHash == null) {
      throw Exception('No account found for this email.');
    }
    final String providedHash = _hashPassword(password);
    if (providedHash != existingHash) {
      throw Exception('Incorrect password.');
    }
    _currentUserEmail = normalizedEmail;
    await _persist();
    notifyListeners();
  }

  Future<void> signOut() async {
    _currentUserEmail = null;
    await _persist();
    notifyListeners();
  }

  String _hashPassword(String password) {
    final List<int> bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<void> _persist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(_emailToPasswordHash));
    if (_currentUserEmail != null) {
      await prefs.setString(_currentUserKey, _currentUserEmail!);
    } else {
      await prefs.remove(_currentUserKey);
    }
  }
}
