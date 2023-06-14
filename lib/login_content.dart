import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  final String text;
  final Function(String text) onTextChanged;
  final VoidCallback onLoginClick;

  LoginContent(
      {required this.text,
      required this.onTextChanged,
      required this.onLoginClick});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: text);
    controller.selection = TextSelection.collapsed(offset: controller.text.length);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              decoration: const InputDecoration(labelText: 'User ID'),
              maxLength: 15,
              controller: controller,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                controller.text = value.trim();
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
                onTextChanged(controller.text);
              },
              onTap: () {
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
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
                onPressed: (text.isEmpty)
                    ? null
                    : () {
                        {
                          onLoginClick();
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
