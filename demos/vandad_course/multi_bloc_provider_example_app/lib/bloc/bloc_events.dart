import 'package:flutter/foundation.dart' show immutable;

/// Implement the application event.
@immutable
abstract class AppEvent {
  const AppEvent();
}

/// Implement the load next url event.
@immutable
class LoadNextUrlEvent implements AppEvent {
  const LoadNextUrlEvent();
}
