import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase/login_content.dart';
import 'package:flutter_showcase/pigeon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logout_content.dart';

enum ScreenState { LOGIN_FORM, LOGOUT }

const String USER_ID_PREF = "userIdKey";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  final ReccoApi _reccoApi = ReccoApi();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late ScreenState _state;
  late Future<String> _userId;
  final TextEditingController _textUserIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userId = _prefs.then((SharedPreferences prefs) {
      final String userId = prefs.getString(USER_ID_PREF) ?? "";
      _updateScreenState(userId);
      return userId;
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
            visible: _state == ScreenState.LOGIN_FORM,
            child: LoginContent(
              textController: _textUserIdController,
              onLoginClick: () {
                _loginReccoSDK(_textUserIdController.text).then((value) {
                  return _updateUser(value);
                }).then((value) {
                  _updateScreenState(value);
                });
              },
            )),
        Visibility(
            visible: _state == ScreenState.LOGOUT,
            child: LogoutContent(
              text: userId,
              onOpenSdkClick: () => _openReccoUI(),
              onLogoutClick: () {
                _logoutReccoSDK().then((value) {
                  return _updateUser("");
                }).then((value) {
                  _updateScreenState(value);
                });
              },
            )),
      ],
    );
  }

  Future<String> _updateUser(String userId) async {
    final SharedPreferences prefs = await _prefs;
    _userId = prefs.setString(USER_ID_PREF, userId).then((bool success) {
      return userId;
    });
    return _userId;
  }

  void _updateScreenState(String userId) {
    setState(() {
      if (userId.isEmpty) {
        _state = ScreenState.LOGIN_FORM;
      } else {
        _state = ScreenState.LOGOUT;
      }
    });
  }

  Future<String> _loginReccoSDK(String userId) async {
    try {
      await _reccoApi.login(userId);
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
    return userId;
  }

  Future<void> _logoutReccoSDK() async {
    try {
      await _reccoApi.logout();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  Future<void> _openReccoUI() async {
    try {
      await _reccoApi.navigateToDashboard();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
}
