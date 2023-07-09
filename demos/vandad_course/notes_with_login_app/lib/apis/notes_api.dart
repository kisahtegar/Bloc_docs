import 'package:flutter/foundation.dart' show immutable;

import '../models.dart';

/// Add notes protocol.
@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

/// And implement the notes API.
@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        // Comparing login handle foobar.
        () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null,
      );
}
