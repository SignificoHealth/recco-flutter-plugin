import 'package:flutter/material.dart';

class ReccoSecondaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedButton;

  const ReccoSecondaryButton(
      {super.key, required this.buttonText, required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF463738),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              side: const BorderSide(width: 2, color: Color(0xFF463738))),
          onPressed: () {
            onPressedButton();
          },
          child: Text(buttonText,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'poppins',
              )),
        ),
      ),
    );
  }
}
