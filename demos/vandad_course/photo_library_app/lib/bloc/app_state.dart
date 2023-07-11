part of 'app_bloc.dart';

/// Implement `AppState` super class.
@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;

  const AppState({
    required this.isLoading,
    this.authError,
  });
}

/// Implement `AppStateLoggedIn`
@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Reference> images;
  const AppStateLoggedIn({
    required bool isLoading,
    required this.user,
    required this.images,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  /// Implement equality, comparring any other object.
  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is AppStateLoggedIn) {
      return isLoading == otherClass.isLoading &&
          user.uid == otherClass.user.uid &&
          images.length == otherClass.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.uid,
        images,
      );

  // Used for debugging purposes and bloc test.
  @override
  String toString() => 'AppStateLoggedIn, images.length = ${images.length}';
}

/// Implement `AppStateLoggedOut`
@immutable
class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  // Used for debugging purposes and bloc test.
  @override
  String toString() =>
      'AppStateLoggedOut, isLoading = $isLoading, authError = $authError';
}

/// Implement `AppStateIsInRegistrationView`.
@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

/// This extension used for extract user in any instance from
/// `AppState`.
extension GetUser on AppState {
  User? get user {
    final cls = this;
    // if this particular class is AppStateLoggedIn then grab the
    // user
    if (cls is AppStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

/// This extension is used to extract images from `AppState`.
extension GetImages on AppState {
  Iterable<Reference>? get images {
    final cls = this;
    // if this particular class is AppStateLoggedIn then grab the
    // images.
    if (cls is AppStateLoggedIn) {
      return cls.images;
    } else {
      return null;
    }
  }
}
