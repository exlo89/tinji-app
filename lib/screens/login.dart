import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tinji/blocs/authentication/authentication_bloc.dart';
import 'package:tinji/blocs/login/login_bloc.dart';
import 'package:tinji/components/standard_button.dart';
import 'package:tinji/components/standard_form_field.dart';
import 'package:tinji/repositories/user_repository.dart';

class Login extends StatefulWidget {
  static final route = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  ]);

  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'E-Mail muss ausgefüllt sein'),
    EmailValidator(errorText: 'Gib eine gültige Email ein')
  ]);

  @override
  void didChangeDependencies() {
    _loginBloc = LoginBloc(
      userRepository: RepositoryProvider.of<UserRepository>(context),
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
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
              child: Form(
                key: _formKey,
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
                          controller: _emailController,
                          validator: _emailValidator,
                        ),
                        StandardFormField(
                          label: 'Password',
                          controller: _passwordController,
                          validator: _passwordValidator,
                          obscureText: true,
                        ),
                        StandardButton(
                          child: Text('login'),
                          onPressed: () {
                            if (_formKey.currentState.validate() && state is! LoginInProgress) {
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonPressed(
                                  email: 'admin@test.de',
                                  password: 'password',
                                ),
                              );
                            }
                          },
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('register');
                          },
                          child: Text('registrieren'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
