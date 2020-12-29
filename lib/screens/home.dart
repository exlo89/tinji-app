import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/bloc/login/login_bloc.dart';
import 'package:tinji/utils/storage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context,state) {
          if (state is LoginInProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(Storage().user.name),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlineButton(
                      child: Text('Logout'),
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(
                          LogoutButtonPressed(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
