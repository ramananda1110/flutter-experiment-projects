import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/HttpException.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) return _token;

    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signUp(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAM2g6BkEhOkEdjSC8M08yvpFRUhA8SL7s';

    try {
      final response = await http.post(url,
          body: json.encode(
            {
              'email': email,
              'password': password,
              'returnSecureToken': true,
            },
          ));

      final responseData = json.decode(response.body);

     // print(responseData);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));


      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAM2g6BkEhOkEdjSC8M08yvpFRUhA8SL7s';

    try {
      final response = await http.post(url,
          body: json.encode(
            {
              'email': email,
              'password': password,
              'returnSecureToken': true,
            },
          ));

      final responseData = json.decode(response.body);

     // print(responseData);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      // auto logout
      _autoLogout();

      final sharePref = await SharedPreferences.getInstance();

      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });

      sharePref.setString("userData", userData);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();

    if (!pref.containsKey("userData")) {
      return false;
    }

    final extractedUserData =
        json.decode(pref.getString("userData")) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;

    notifyListeners();

    _autoLogout();

    return true;
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final pref = await SharedPreferences.getInstance();

    // pref.remove("userData");

    pref.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeExpired = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeExpired), logout);
  }
}
