import 'package:flutter/material.dart';

import '../utils/api_client.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiClient _client = ApiClient();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onSaved: (value) {
                print(value);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              onSaved: (value) {
                print(value);
              },
            ),
            SizedBox(
              width: double.infinity,
              child: OutlineButton(
                child: Text('Login'),
                onPressed: () {
                  print('jooo');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
