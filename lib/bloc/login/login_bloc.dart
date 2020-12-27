import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinji/bloc/authentication/authentication_bloc.dart';
import 'package:tinji/repositories/authentication_repository.dart';
import 'package:tinji/repositories/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationRepository,
    @required this.authenticationBloc,
  })  : assert(authenticationRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // login
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      try {
        final token = await authenticationRepository.authentication(
          email: event.email,
          password: event.password,
        );
        await authenticationRepository.writeToken(token);
        authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error);
      }
    }

    // logout
    if (event is LogoutButtonPressed) {
      yield LoginInProgress();
      try {
        await authenticationRepository.deleteToken();
        authenticationBloc.add(AuthenticationLoggedOut());
      } catch (error) {
        yield LoginFailure(error: error);
      }
    }
  }
}
