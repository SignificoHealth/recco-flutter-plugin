import 'package:flutter/material.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text(
                "Current userId: $text",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
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
                          onOpenSdkClick();
                        }
                      },
                child: const Text('Open SDK'),
              ),
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
                          onLogoutClick();
                        }
                      },
                child: const Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
