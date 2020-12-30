import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/bloc/authentication/authentication_bloc.dart';
import 'package:tinji/bloc/login/login_bloc.dart';

class ErrorPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ErrorPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('error screen'),
      ),
    );
  }
}
