import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_state.dart';
import '../bloc/bloc_events.dart';
import '../extensions/stream/start_with.dart';

/// This `AppBlocView` is a generic view. This is basically allowing us to create
/// two instances of this `AppBloc` view. One of which is going to work with the
/// `TopBloc`, the other is going to work with the `BottomBloc`.
class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({super.key});

  /// Implements the updating functionality that creating a `stream` that goes it
  /// takes every `10 second` but immediately `starts with an event` then dispatching
  /// event to our context.
  /// (event -> 10 second -> event -> 10 second -> event ...)
  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      // Provide an event for every tick of the stream.
      (_) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(
            event,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, appState) {
          if (appState.error != null) {
            // we have an error
            return const Text(
              'An error occurred. Try again in a moment!',
            );
          } else if (appState.data != null) {
            // we have data
            return Image.memory(
              appState.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            // loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
