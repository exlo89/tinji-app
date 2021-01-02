import 'package:flutter/material.dart';

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
