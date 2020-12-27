import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:tinji/bloc/authentication/authentication_bloc.dart';
import 'package:tinji/data_provider/authentication_provider.dart';
import 'package:tinji/data_provider/user_provider.dart';
import 'package:tinji/repositories/authentication_repository.dart';
import 'package:tinji/screens/home.dart';
import 'package:tinji/screens/login.dart';
import 'package:tinji/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load configuration
  if (kReleaseMode) {
    await GlobalConfiguration().loadFromAsset("production");
  } else {
    await GlobalConfiguration().loadFromAsset("develop");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        authenticationRepository: AuthenticationRepository(
          authenticationProvider: AuthenticationProvider(),
          userProvider: UserProvider(),
        ),
      )..add(AuthenticationAppStarted()),
      child: MaterialApp(
        title: 'Tinji',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return Home();
                }
                if (state is AuthenticationUnauthenticated) {
                  return Login();
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
          '/register': (context) => Register(),
          '/home': (context) => Home(),
        },
      ),
    );
  }
}
