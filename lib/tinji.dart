import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/repositories/user_repository.dart';
import 'package:tinji/screens/home.dart';
import 'package:tinji/screens/login.dart';
import 'package:tinji/screens/register.dart';
import 'package:tinji/screens/splash_page.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/login/login_bloc.dart';

class Tinji extends StatefulWidget {
  @override
  _TinjiState createState() => _TinjiState();
}

class _TinjiState extends State<Tinji> {
  AuthenticationBloc _authenticationBloc;
  LoginBloc _loginBloc;

  UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    // ini repositories
    _userRepository = UserRepository();

    //ini blocs
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: _authenticationBloc,
    );

    // trigger app start event
    _authenticationBloc.add(AuthenticationAppStarted());
  }


  @override
  void dispose() {
    _authenticationBloc.close();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (context) => _authenticationBloc),
        BlocProvider<LoginBloc>(create: (context) => _loginBloc),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(create: (context) => _userRepository),
        ],
        child: MaterialApp(
          title: 'Tinji',
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                return Home();
              }
              if (state is AuthenticationUnauthenticated) {
                return Login();
              }
              if (state is AuthenticationFailure) {
                return SplashPage();
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          routes: {
            'home': (context) => Home(),
            'register': (context) => Register(),
            'login': (context) => Login(),
          },
        ),
      ),
    );
  }
}
