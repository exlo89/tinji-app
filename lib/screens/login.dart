import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hjoojjo0');

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onSaved: (value){
                print(value);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              onSaved: (value){
                print(value);
              },
            ),
            OutlineButton(
              child: Text('Login'),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
