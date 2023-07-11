part of 'app_bloc.dart';

/// Implement `AppEvent`
@immutable
abstract class AppEvent {
  const AppEvent();
}

/// Implement `AppEventUploadImage` when user pick image we going to get a path
/// to that image then we gonna send to bloc.
@immutable
class AppEventUploadImage implements AppEvent {
  final String filePathToUpload;

  const AppEventUploadImage({
    required this.filePathToUpload,
  });
}

/// Implement `AppEventDeleteAccount` this event used for delete account.
@immutable
class AppEventDeleteAccount implements AppEvent {
  const AppEventDeleteAccount();
}

/// Implement `AppEventLogout` this event used for log out.
@immutable
class AppEventLogOut implements AppEvent {
  const AppEventLogOut();
}

/// Implement `AppEventInitialize` this event used for initialize app.
@immutable
class AppEventInitialize implements AppEvent {
  const AppEventInitialize();
}

/// Implement `AppEventLogIn` this event used for log in.
@immutable
class AppEventLogIn implements AppEvent {
  final String email;
  final String password;

  const AppEventLogIn({
    required this.email,
    required this.password,
  });
}

/// Implement `AppEventGoToRegistration` this event used to go registration page.
@immutable
class AppEventGoToRegistration implements AppEvent {
  const AppEventGoToRegistration();
}

/// Implement `AppEventGoToLogin` this event used to go login page.
@immutable
class AppEventGoToLogin implements AppEvent {
  const AppEventGoToLogin();
}

/// Implement `AppEventRegister` this event used for register user.
@immutable
class AppEventRegister implements AppEvent {
  final String email;
  final String password;

  const AppEventRegister({
    required this.email,
    required this.password,
  });
}
