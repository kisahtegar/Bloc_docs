import 'package:flutter/foundation.dart' show immutable;

import '../models.dart';

/// Add a login protocol to login_api.
@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

/// Implement the login API.
@immutable
class LoginApi implements LoginApiProtocol {
  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null,
      );
}
