import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tinji/blocs/login/login_bloc.dart';
import 'package:tinji/components/standard_button.dart';
import 'package:tinji/components/standard_form_field.dart';
import 'package:tinji/screens/register_stepper.dart';

class Register extends StatelessWidget {
  static final route = 'register';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'E-Mail muss ausgefüllt sein'),
    EmailValidator(errorText: 'Gib eine gültige Email ein')
  ]);

  final _nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name muss ausgefüllt sein'),
  ]);

  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Passwort muss ausgefüllt sein'),
  ]);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(RegisterStepper.route, (route) => false);
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
                heightFactor: 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StandardFormField(
                        label: 'Name',
                        controller: _nameController,
                        validator: _nameValidator,
                      ),
                      StandardFormField(
                        label: 'Email',
                        controller: _emailController,
                        validator: _emailValidator,
                      ),
                      StandardFormField(
                        label: 'Password',
                        controller: _passwordController,
                        obscureText: true,
                        validator: _passwordValidator,
                      ),
                      StandardFormField(
                        label: 'Password bestätigen',
                        controller: _passwordConfirmationController,
                        obscureText: true,
                        validator: _passwordValidator,
                      ),
                      StandardButton(
                        child: Text('registrieren'),
                        onPressed: () {
                          if (state is! LoginInProgress) {
                            if (_formKey.currentState.validate()) {
                              BlocProvider.of<LoginBloc>(context).add(
                                RegisterButtonPressed(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  passwordConfirmation: _passwordConfirmationController.text,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
