import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/blocs/login/login_bloc.dart';
import 'package:tinji/components/standard_button.dart';
import 'package:tinji/components/standard_form_field.dart';

class Login extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
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
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: AlignmentDirectional.center,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'Tinji',
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                    StandardFormField(
                      label: 'Email',
                    ),
                    StandardFormField(
                      label: 'Password',
                      obscureText: true,
                    ),
                    StandardButton(
                      child: Text('login'),
                      onPressed: () {
                        if (state is !LoginInProgress) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginButtonPressed(
                              email: 'admin@test.de',
                              password: 'password',
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
