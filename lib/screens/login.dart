import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/bloc/authentication/authentication_bloc.dart';
import 'package:tinji/bloc/login/login_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationRepository: BlocProvider.of<AuthenticationBloc>(context).authenticationRepository,
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        ),
        child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              print(state);
              if (state is LoginSuccess) {
                Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
              }
              if (state is LoginFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginInProgress) {
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      onSaved: (value) {
                        print(value);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      onSaved: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlineButton(
                        child: Text('Login'),
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(
                            LoginButtonPressed(
                              email: 'admin@test.de',
                              password: 'password',
                            ),
                          );
                          print('jooo');
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
        )
      ),
    );
  }
}
