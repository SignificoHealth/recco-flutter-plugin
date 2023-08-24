import 'dart:async';

import 'login_content.dart';
import 'logout_content.dart';

import 'package:recco/recco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ScreenState { loginForm, logout }

const String userIdPref = "userIdKey";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Recco Showcase',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF463738),
        onPrimary: const Color(0xFFF6F190),
        secondary: const Color(0xFFF6F190),
        onSecondary: const Color(0xFFEBEBEB),
        surface: const Color(0xFFEBEBEB),
      )),
      home: const MyHomePage(title: 'Recco - Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Recco _reccoPlugin = Recco();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late ScreenState _state;
  late Future<String> _userId;
  final TextEditingController _textUserIdController = TextEditingController();

  @override
  void initState() {
    _initializeRecco(
        "99ItJU5LzZKmLggRvGJMWWxd9mEek7MKedmkZ4_3Wb4yKVJ17lm3K6Smh8eUp3GuFIPq0-w");

    super.initState();
    _userId = _prefs.then((SharedPreferences prefs) {
      final String userId = prefs.getString(userIdPref) ?? "";
      return userId;
    }).then((value) {
      _state = value.isEmpty ? ScreenState.loginForm : ScreenState.logout;
      _updateScreenState(_state);
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<String>(
            future: _userId,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final userId = snapshot.data!;
                    return _successContent(userId);
                  }
              }
            }));
  }

  Widget _successContent(String userId) {
    return Column(
      children: [
        Visibility(
            visible: _state == ScreenState.loginForm,
            child: LoginContent(
              textController: _textUserIdController,
              onLoginClick: () {
                _loginReccoSDK(_textUserIdController.text).then((value) {
                  return _updateUser(value);
                }).then((value) {
                  _updateScreenState(ScreenState.logout);
                });
              },
            )),
        Visibility(
            visible: _state == ScreenState.logout,
            child: LogoutContent(
              text: userId,
              onOpenSdkClick: () => _openReccoUI(),
              onLogoutClick: () {
                _logoutReccoSDK().then((value) {
                  return _updateUser("");
                }).then((value) {
                  _updateScreenState(ScreenState.loginForm);
                });
              },
            )),
      ],
    );
  }

  Future<String> _updateUser(String userId) async {
    final SharedPreferences prefs = await _prefs;
    _userId = prefs.setString(userIdPref, userId).then((bool success) {
      return userId;
    });
    return _userId;
  }

  void _updateScreenState(ScreenState state) {
    setState(() {
      _state = state;
    });
  }

  Future<void> _initializeRecco(String clientSecret) async {
    try {
      _reccoPlugin.initialize(clientSecret, ReccoStyle.spring());
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  Future<String> _loginReccoSDK(String userId) async {
    try {
      _reccoPlugin.login(userId);
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
    return userId;
  }

  Future<void> _logoutReccoSDK() async {
    try {
      _reccoPlugin.logout();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  Future<void> _openReccoUI() async {
    try {
      _reccoPlugin.openReccoUI();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
}
