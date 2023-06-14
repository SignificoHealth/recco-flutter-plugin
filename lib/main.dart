import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase/login_content.dart';
import 'package:flutter_showcase/pigeon.dart';

import 'logout_content.dart';

enum ScreenState { LOGIN_FORM, LOGOUT }

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
      home: const MyHomePage(title: 'Flutter Demo Shadowflight'),
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
  final ShadowflightApi _shadowflightApi = ShadowflightApi();
  String _userId = "";
  ScreenState _state = ScreenState.LOGIN_FORM;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Visibility(
              visible: _state == ScreenState.LOGIN_FORM,
              child: LoginContent(
                text: _userId,
                onTextChanged: (text) {
                  setState(() {
                    _userId = text.trim();
                  });
                },
                onLoginClick: () {
                  _loginShadowflightSDK(_userId, () {
                    setState(() {
                      _state = ScreenState.LOGOUT;
                    });
                  });
                },
              )),
          Visibility(
              visible: _state == ScreenState.LOGOUT,
              child: LogoutContent(
                text: _userId,
                onOpenSdkClick: () => _openShadowflightUI(),
                onLogoutClick: () {
                  setState(() {
                    _userId = "";
                    _logoutShadowflightSDK(() {
                      setState(() {
                        _state = ScreenState.LOGIN_FORM;
                      });
                    });
                  });
                },
              )),
        ],
      ),
    );
  }

  Future<void> _loginShadowflightSDK(
      String userId, VoidCallback onSuccess) async {
    try {
      await _shadowflightApi.login(userId);
      onSuccess();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  Future<void> _logoutShadowflightSDK(VoidCallback onSuccess) async {
    try {
      await _shadowflightApi.logout();
      onSuccess();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  Future<void> _openShadowflightUI() async {
    try {
      await _shadowflightApi.navigateToDashboard();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
}
