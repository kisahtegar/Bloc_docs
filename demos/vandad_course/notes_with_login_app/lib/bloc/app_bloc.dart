import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_login_app/apis/login_api.dart';
import 'package:notes_with_login_app/bloc/actions.dart';

import '../apis/notes_api.dart';
import '../models.dart';
import 'app_state.dart';

/// Define the app bloc with 2 actions.
class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApiProtocol;
  final NotesApiProtocol notesApiProtocol;

  AppBloc({
    required this.loginApiProtocol,
    required this.notesApiProtocol,
  }) : super(const AppState.empty()) {
    // Handle the LoginAction in the constructor.
    on<LoginAction>((event, emit) async {
      // Start with loading.
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );
      // Log the user in.
      final loginHandle = await loginApiProtocol.login(
        email: event.email,
        password: event.password,
      );
      // Last emit.
      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    // Handle the LoadNotesAction in the constructor.
    on<LoadNotesAction>((event, emit) async {
      // Start with loading.
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          // Carrying previous loadingHandle.
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );

      // Get the login handle.
      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.fooBar()) {
        // Invalid login handle, cannot fetch notes.
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
        return;
      }

      // We have a valid login handle and want to fetch notes.
      final notes = await notesApiProtocol.getNotes(
        loginHandle: loginHandle!,
      );

      // Last emit.
      emit(
        AppState(
          isLoading: false,
          loginError: null,
          loginHandle: loginHandle,
          fetchedNotes: notes,
        ),
      );
    });
  }
}
