import 'dart:typed_data' show Uint8List;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_bloc_provider_example_app/bloc/app_bloc.dart';
import 'package:multi_bloc_provider_example_app/bloc/app_state.dart';
import 'package:multi_bloc_provider_example_app/bloc/bloc_events.dart';

// This extension on String that allows to return the data for any string object.
extension ToList on String {
  Uint8List toUint8List() => Uint8List.fromList(codeUnits);
}

// Mock text data.
final text1Data = 'Foo'.toUint8List();
final text2Data = 'Bar'.toUint8List();

// mock errors.
enum Errors { dummy }

void main() {
  // Add test for initial state.
  blocTest<AppBloc, AppState>(
    'Initial state of the bloc should be empty',
    build: () => AppBloc(
      urls: [],
    ),
    verify: (appBloc) => expect(
      appBloc.state,
      const AppState.empty(),
    ),
  );

  // Load valid data and compare states.
  blocTest<AppBloc, AppState>(
    'Test the ability to load a URL',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text1Data,
        error: null,
      )
    ],
  );

  // test throwing an error from url loader
  blocTest<AppBloc, AppState>(
    'Throw an error in url loader and catch it',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.error(Errors.dummy),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      const AppState(
        isLoading: false,
        data: null,
        error: Errors.dummy,
      )
    ],
  );

  // add test for loading two URLs.
  blocTest<AppBloc, AppState>(
    'Test the ability to load more than one URL',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text2Data),
    ),
    act: (appBloc) {
      appBloc.add(
        const LoadNextUrlEvent(),
      );
      appBloc.add(
        const LoadNextUrlEvent(),
      );
    },
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text2Data,
        error: null,
      )
    ],
  );
}
