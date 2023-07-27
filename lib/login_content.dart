import 'package:flutter/material.dart';

import 'constants/strings.dart';
import 'widgets/recco_primary_button.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onLoginClick;

  const LoginContent(
      {super.key, required this.textController, required this.onLoginClick});

  @override
  Widget build(BuildContext context) {
    textController.selection =
        TextSelection.collapsed(offset: textController.text.length);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/images/bg_logo.webp')),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48.0),
                  child: Text(Strings.loginMessage,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF463738),
                        fontFamily: 'poppins',
                      ))),
              TextField(
                decoration: const InputDecoration(labelText: 'User ID'),
                controller: textController,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  textController.text = value.trim();
                  textController.selection = TextSelection.collapsed(
                      offset: textController.text.length);
                },
                onTap: () {
                  textController.selection = TextSelection.collapsed(
                      offset: textController.text.length);
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ReccoPrimaryButton(
                    buttonText: Strings.loginButton,
                    onPressedButton: () {
                      onLoginClick();
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
