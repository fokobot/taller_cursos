import 'dart:developer' as developer;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserModel extends ChangeNotifier {
  String token;
  String username;
  String name;
  bool status = false;

  UserModel({this.token, this.username, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    developer.log('log me', name: 'DEBUG');
    return UserModel(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }

  Future<UserModel> signIn(String email, String password) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      notifyListeners();
      var user = UserModel.fromJson(json.decode(response.body));
      this.token = user.token;
      this.name = user.name;
      this.username = user.username;
      this.status = true;
      return user;
    } else {
      print("signIn failed");
      print('${response.body}');
      //throw Exception(response.body);
    }
  }

  /*Future<void> verifyStatus() async {
    final prefs = await SharedPreferences.getInstance();
    this.status = prefs.getBool('status') ?? false;
    this.name = prefs.getString('name');
    this.username = prefs.getString('username');
    this.token = prefs.getString('token');
    notifyListeners();
  }*/

  void verifyStatus() async {
    // petición
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/check/token',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'token': token}),
    );
    print('${response.body}');
    print('${response.statusCode}');
    Map<String, dynamic> json = jsonDecode(response.body);
    this.status = json['valid'];
    this.name = prefs.getString('name');
    this.username = prefs.getString('username');
    this.token = token;
    notifyListeners();
  }

  Future<UserModel> signUp(
      String email, String password, String username, String name) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'username': username,
        'name': name
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      notifyListeners();
      return UserModel.fromJson(json.decode(response.body));
    } else {
      print("signup failed");
      print('${response.body}');
      //throw Exception(response.body);
    }
  }

  Future<void> setLoggedIn(String username) async {
    this.status = true;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', this.token);
    prefs.setString('username', this.username);
    prefs.setString('name', this.name);
    prefs.setBool('status', this.status);
    notifyListeners();
  }

  Future<void> signOut() async {
    this.status = false;
    this.name = "";
    this.username = "";
    this.token = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', this.status);
    notifyListeners();
  }
}
