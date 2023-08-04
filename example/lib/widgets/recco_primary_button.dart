import 'package:flutter/material.dart';

class ReccoPrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function? onPressedButton;

  const ReccoPrimaryButton(
      {super.key, required this.buttonText, required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          onPressed: () {
            onPressedButton!();
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
