import 'package:flutter/material.dart';

class StandardFormField extends StatelessWidget {
  final String label;
  final bool obscureText;

  const StandardFormField({
    Key key,
    @required this.label,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
        ),
        obscureText: obscureText,
        onSaved: (value) {
          print(value);
        },
      ),
    );
  }
}
