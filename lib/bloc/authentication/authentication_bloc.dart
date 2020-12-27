import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tinji/repositories/authentication_repository.dart';
import 'package:tinji/repositories/user_repository.dart';
import 'package:tinji/utils/storage.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({@required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    // on app start
    if (event is AuthenticationAppStarted) {
      final bool hasToken = await authenticationRepository.hasToken();
      Storage().isLoggedIn = hasToken;
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
  }
}
