import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/blocs/authentication/authentication_bloc.dart';
import 'package:tinji/blocs/login/login_bloc.dart';
import 'package:tinji/blocs/messenger/messenger_bloc.dart';
import 'package:tinji/repositories/user_repository.dart';
import 'package:tinji/screens/home.dart';
import 'package:tinji/screens/login.dart';
import 'package:tinji/screens/register.dart';
import 'package:tinji/screens/splash.dart';
import 'package:tinji/utils/routes.dart';

class Tinji extends StatefulWidget {
  @override
  _TinjiState createState() => _TinjiState();
}

class _TinjiState extends State<Tinji> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AuthenticationBloc _authenticationBloc;
  LoginBloc _loginBloc;
  MessengerBloc _messengerBloc;

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
    _messengerBloc = MessengerBloc();

    // trigger app start event
    _authenticationBloc.add(AuthenticationAppStarted());
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    _loginBloc.close();
    _messengerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (context) => _authenticationBloc),
        BlocProvider<LoginBloc>(create: (context) => _loginBloc),
        BlocProvider<MessengerBloc>(create: (context) => _messengerBloc),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(create: (context) => _userRepository),
        ],
        child: MaterialApp(
          title: 'Tinji',
          navigatorKey: _navigatorKey,
          routes: routes,
          builder: (context, child) {
            // listen to the authentication state and route to home or login
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  _navigatorKey.currentState.pushNamedAndRemoveUntil(Home.route, (route) => false);
                }
                if (state is AuthenticationUnauthenticated) {
                  _navigatorKey.currentState.pushNamedAndRemoveUntil(Login.route, (route) => false);
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => Splash.route(),
          theme: ThemeData(
            primaryColor: Color(0xff028E9B),
            primaryColorDark: Color(0xff015C65),
            accentColor: Color(0xff133CAC),
            backgroundColor: Color(0xffeeeeee),
            buttonTheme: ButtonThemeData(
                height: 50,
                minWidth: double.infinity,
                buttonColor: Color(0xff028E9B),
                textTheme: ButtonTextTheme.primary),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
