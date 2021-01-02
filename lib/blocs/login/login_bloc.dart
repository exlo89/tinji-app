import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinji/blocs/authentication/authentication_bloc.dart';
import 'package:tinji/repositories/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;

  LoginBloc({this.authenticationBloc, this.userRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // login
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      try {
        String token = await userRepository.authentication(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error);
      }
    }
  }
}
