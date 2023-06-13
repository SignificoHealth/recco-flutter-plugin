import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase/pigeon.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Shadowflight'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController(text: "");
  final ShadowflightApi _shadowflightApi = ShadowflightApi();
  Message _message = Message(title: "", text: "");
  String _userId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'User ID'),
                maxLength: 15,
                controller: _controller,
                textInputAction: TextInputAction.done,
                onChanged: (text) {
                  setState(() {
                    _userId = text.trim();
                  });

                  _shadowflightApi.replyBackTest(text).then((value) {
                    final response = "${value.title}: ${value.text}";
                    debugPrint("result=$response");
                    setState(() {
                      _message = value;
                    });
                  }, onError: (error, stacktrace) {
                    debugPrint(error);
                    debugPrintStack(stackTrace: stacktrace);
                  });
                },
                onSubmitted: (text) {
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  "${_message.title}: ${_message.text}",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: ElevatedButton(
                  child: const Text('Open SDK'),
                  onPressed: (_userId.isEmpty)
                      ? null
                      : () {
                          {
                            _openShadowflightUI();
                          }
                        },
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _openShadowflightUI() async {
    try {
      await _shadowflightApi.openShadowflightSDK(_userId);
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
}
