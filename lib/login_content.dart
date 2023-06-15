import 'package:flutter/material.dart';


class LoginContent extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onLoginClick;

  const LoginContent(
      {super.key, required this.textController, required this.onLoginClick});

  @override
  State<LoginContent> createState() => _LoginContent();
}

class _LoginContent extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    final textController = widget.textController;
    bool disableLoginCta = textController.text.isEmpty;
    textController.selection =
        TextSelection.collapsed(offset: textController.text.length);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              decoration: const InputDecoration(labelText: 'User ID'),
              maxLength: 15,
              controller: textController,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                setState(() {
                  disableLoginCta = value.isEmpty;
                });
                textController.text = value.trim();
                textController.selection =
                    TextSelection.collapsed(offset: textController.text.length);
              },
              onTap: () {
                textController.selection =
                    TextSelection.collapsed(offset: textController.text.length);
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: (disableLoginCta)
                    ? null
                    : () {
                        {
                          widget.onLoginClick();
                        }
                      },
                child: const Text('Login'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
