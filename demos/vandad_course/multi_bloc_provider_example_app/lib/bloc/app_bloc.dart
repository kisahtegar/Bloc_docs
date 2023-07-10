import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';
import 'bloc_events.dart';

/// function to pick random url.
typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

/// function url loader.
typedef AppBlocUrlLoader = Future<Uint8List> Function(String url);

/// This extension is used to get random element.
extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        math.Random().nextInt(length),
      );
}

// Implement app bloc.
class AppBloc extends Bloc<AppEvent, AppState> {
  /// This private function will pick random url.
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  /// This function will load url and return a data.
  Future<Uint8List> _loadUrl(String url) => NetworkAssetBundle(Uri.parse(url))
      .load(url)
      .then((byteData) => byteData.buffer.asUint8List());

  AppBloc({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
    AppBlocRandomUrlPicker? urlPicker, // dependencies injection.
    AppBlocUrlLoader? urlLoader, // Dependencies injection
  }) : super(const AppState.empty()) {
    // Load next url event.
    on<LoadNextUrlEvent>((event, emit) async {
      // Start loading
      emit(
        const AppState(
          isLoading: true,
          data: null,
          error: null,
        ),
      );

      // Either take urlPicker that is provided to us an optional parameter,
      // or we use our in it built in _pickRandomUrl functions.
      final url = (urlPicker ?? _pickRandomUrl)(urls);

      try {
        // This going to create artifical weight wich allow circular progress
        // indicator to be displayed for while.
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }

        // Either take urlLoader that is provided to us an optional parameter,
        // or we use our in it built in _loadUrl functions.
        final data = await (urlLoader ?? _loadUrl)(url);

        // Emit data.
        emit(
          AppState(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (e) {
        // Emit failed.
        emit(
          AppState(
            isLoading: false,
            data: null,
            error: e,
          ),
        );
      }
    });
  }
}
