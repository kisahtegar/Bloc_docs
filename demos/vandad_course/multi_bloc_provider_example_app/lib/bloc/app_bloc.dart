import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';
import 'bloc_events.dart';

/// function to pick random url.
typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

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

  AppBloc({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
    AppBlocRandomUrlPicker? urlPicker, // dependencies injection.
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

      // Pick the url
      final url = (urlPicker ?? _pickRandomUrl)(urls);
      try {
        // This going to create artifical weight wich allow circular progress
        // indicator to be displayed for while.
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }

        // Create network asset bundle.
        final bundle = NetworkAssetBundle(Uri.parse(url));

        // load contents from bundle.
        final data = (await bundle.load(url)).buffer.asUint8List();

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
