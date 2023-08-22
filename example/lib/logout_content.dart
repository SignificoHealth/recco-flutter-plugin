import 'package:flutter/material.dart';

import 'constants/strings.dart';
import 'widgets/recco_primary_button.dart';
import 'widgets/recco_secondary_button.dart';

class LogoutContent extends StatelessWidget {
  final String text;
  final VoidCallback onOpenSdkClick;
  final VoidCallback onLogoutClick;

  const LogoutContent(
      {super.key,
      required this.text,
      required this.onOpenSdkClick,
      required this.onLogoutClick});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage('assets/images/bg_logo.webp')),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 64),
                child:
                    Image(image: AssetImage('assets/images/bg_shapes.webp'))),
            Padding(
                padding: const EdgeInsets.only(top: 48),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF463738),
                        fontFamily: 'poppins',
                      ),
                      children: <TextSpan>[
                        TextSpan(text: Strings.welcomeGreeting),
                        TextSpan(
                            text: Strings.welcomeCompanyName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: Strings.welcomeMessage),
                        TextSpan(
                            text: Strings.welcomeProductName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ))),
            Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ReccoPrimaryButton(
                              buttonText: Strings.openReccoButton,
                              onPressedButton: () {
                                onOpenSdkClick();
                              }),
                          ReccoSecondaryButton(
                            buttonText: Strings.logoutButton,
                            onPressedButton: () {
                              onLogoutClick();
                            },
                          ),
                        ])))
          ],
        ),
      ),
    );
  }
}
