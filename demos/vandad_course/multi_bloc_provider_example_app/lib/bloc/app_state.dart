import 'dart:typed_data' show Uint8List;

import 'package:flutter/foundation.dart' show immutable;

// Implement application state.
@immutable
class AppState {
  // This properties contains data for images and error.
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const AppState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  // Initial state of bloc (default state).
  const AppState.empty()
      : isLoading = false,
        data = null,
        error = null;

  // Print out to debug console.
  @override
  String toString() => {
        'isLoading': isLoading,
        'hasData': data != null,
        'error': error,
      }.toString();

  // Implement equality for AppState.
  @override
  bool operator ==(covariant AppState other) =>
      isLoading == other.isLoading &&
      (data ?? []).isEqualTo(other.data ?? []) &&
      error == other.error;

  @override
  int get hashCode => Object.hash(
        isLoading,
        data,
        error,
      );
}

///  Extension for equality on List.
extension Comparison<E> on List<E> {
  /// This fuction will check if the list is equal to another list.
  bool isEqualTo(List<E> other) {
    // Checking if the same instance.
    if (identical(this, other)) {
      return true;
    }

    // Checking if their length not same.
    if (length != other.length) {
      return false;
    }

    // Checking byte comparison.
    // If any of those bytes at that index are not equal to the other one, then
    // we're going return false. But if this goes through and all the bytes are
    // equal then we're going to return true at the end.
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
