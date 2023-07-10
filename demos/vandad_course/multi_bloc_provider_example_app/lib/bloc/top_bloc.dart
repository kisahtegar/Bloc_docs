import 'app_bloc.dart';

/// Creating seperate bloc for app bloc and this function will
/// Implement the top bloc.
class TopBloc extends AppBloc {
  TopBloc({
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
  }) : super(
          waitBeforeLoading: waitBeforeLoading,
          urls: urls,
        );
}
