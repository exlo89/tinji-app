import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tinji/repositories/user_repository.dart';
import 'package:tinji/utils/storage.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({UserRepository userRepository})
      : userRepository = userRepository ?? UserRepository(),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    // on app start
    if (event is AuthenticationAppStarted) {
      final bool hasToken = await userRepository.hasToken();
      Storage().isLoggedIn = hasToken;
      if (hasToken) {
        Storage().user = await userRepository.getUser();
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    // on login
    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await userRepository.writeToken(event.token);
      Storage().isLoggedIn = true;
      yield AuthenticationAuthenticated();
    }

    // on logout
    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await userRepository.deleteToken();
      Storage().isLoggedIn = false;
      yield AuthenticationUnauthenticated();
    }
  }
}
