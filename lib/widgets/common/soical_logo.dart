import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Image.asset(
        icon,
        width: 40,
        height: 40,
      ),
    );
  }
}

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'or Sign Up with',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              icon: 'assets/icons/apple.png',
              onPressed: () {
                // Implement Apple sign in
              },
            ),
            const SizedBox(width: 20),
            SocialButton(
              icon: 'assets/icons/google.png',
              onPressed: () {
                // Implement Google sign in
              },
            ),
          ],
        ),
      ],
    );
  }
}