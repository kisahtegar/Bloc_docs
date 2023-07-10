import 'app_bloc.dart';

/// Creating seperate bloc for app bloc and this function will
/// Implement the bottom bloc.
class BottomBloc extends AppBloc {
  BottomBloc({
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
  }) : super(
          waitBeforeLoading: waitBeforeLoading,
          urls: urls,
        );
}
