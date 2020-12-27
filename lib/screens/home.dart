import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/bloc/authentication/authentication_bloc.dart';
import 'package:tinji/bloc/login/login_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hjoojjo0');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tinji'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationRepository: BlocProvider.of<AuthenticationBloc>(context).authenticationRepository,
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        ),
        child: Builder(
          builder: (context) {
            return Center(
              child: SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  child: Text('Logout'),
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(
                      LogoutButtonPressed(),
                    );
                    print('jooo');
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
