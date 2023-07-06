import 'package:flutter/material.dart';

import '../strings.dart' show enterYourPasswordHere;

/// Widget for password text field.
class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    super.key,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      obscuringCharacter: '◉',
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),
    );
  }
}
