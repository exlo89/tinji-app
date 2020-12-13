import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/bloc/authentication_bloc.dart';
import 'package:tinji/repositories/user_repository.dart';
import 'package:tinji/screens/home.dart';
import 'package:tinji/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: UserRepository())..add(AuthenticationAppStarted()),
      child: MaterialApp(
        title: 'Tinji',
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            print(state);
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
        ),
      ),
    );
  }
}
