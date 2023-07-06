import 'package:flutter/foundation.dart' show immutable;

/// We neeed a login handle.
@immutable
class LoginHandle {
  final String token;

  const LoginHandle({
    required this.token,
  });

  const LoginHandle.fooBar() : token = 'foobar';

  // Logging for debug console.
  @override
  String toString() => 'LoginHandle (token = $token)';

  // Adding login handle with equality and hashCode.
  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;
}

/// Login errors
enum LoginErrors {
  invalidHandle,
}

/// And a simple note class.
@immutable
class Note {
  final String title;

  const Note({
    required this.title,
  });

  // Logging for debug console.
  @override
  String toString() => 'Note (title = $title)';
}

/// Create your mock notes as well.
final mockNotes = Iterable.generate(
  3,
  (i) => Note(title: 'Note ${i + 1}'),
);
