import 'package:flutter/foundation.dart' show immutable;

/// Define main app action.
@immutable
abstract class AppAction {
  const AppAction();
}

/// Login action.
@immutable
class LoginAction implements AppAction {
  final String email;
  final String password;

  const LoginAction({
    required this.email,
    required this.password,
  });
}

/// Load notes action.
@immutable
class LoadNotesAction implements AppAction {
  const LoadNotesAction();
}
