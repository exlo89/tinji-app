import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tinji/blocs/authentication/authentication_bloc.dart';
import 'package:tinji/blocs/login/login_bloc.dart';
import 'package:tinji/repositories/user_repository.dart';

class RegisterStepper extends StatefulWidget {
  static final route = 'register_stepper';

  @override
  _RegisterStepperState createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
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

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != steps.length ? goTo(currentStep + 1) : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  List<Step> steps = [
    Step(
      title: Text('Basics'),
      subtitle: Text('jooooo'),
      isActive: true,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Email Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      title: const Text('Address'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Home Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Postcode'),
          ),
        ],
      ),
    ),
    Step(
      title: const Text('Avatar'),
      subtitle: const Text("Error!"),
      content: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                steps: steps,
                currentStep: currentStep,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
                onStepCancel: cancel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
