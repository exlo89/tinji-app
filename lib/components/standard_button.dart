import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const StandardButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
