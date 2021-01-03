import 'package:flutter/material.dart';

class StandardFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function onSave;
  final TextEditingController controller;

  const StandardFormField({
    Key key,
    @required this.label,
    this.obscureText = false,
    this.onSave,
    this.controller,
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
        onSaved: onSave,
        controller: controller,
      ),
    );
  }
}
