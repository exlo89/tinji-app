import 'package:flutter/material.dart';

class StandardFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function onSave;
  final TextEditingController controller;
  final FormFieldValidator validator;

  const StandardFormField({
    Key key,
    @required this.label,
    this.obscureText = false,
    this.onSave,
    this.controller,
    this.validator,
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
        validator: validator,
      ),
    );
  }
}
