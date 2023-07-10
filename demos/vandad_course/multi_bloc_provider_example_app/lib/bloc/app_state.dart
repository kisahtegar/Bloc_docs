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
}
