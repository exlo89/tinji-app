import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/blocs/authentication/authentication_bloc.dart';
import 'package:tinji/blocs/login/login_bloc.dart';
import 'package:tinji/blocs/messenger/messenger_bloc.dart';
import 'package:tinji/components/standard_button.dart';
import 'package:tinji/utils/storage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Storage().user.name),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
          }
          if (state is AuthenticationFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginInProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            alignment: AlignmentDirectional.center,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Storage().user.name),
                  StandardButton(
                    child: Text('Snackbar'),
                    onPressed: () {
                      BlocProvider.of<MessengerBloc>(context)
                          .add(MessengerSentErrorMessage(message: 'jooooooo', context: context));
                      //BlocProvider.of<MessengerBloc>(context).add(MessengerSentSuccessMessage(message: 'jooooooo'));
                      //BlocProvider.of<MessengerBloc>(context).add(MessengerSentSuccessMessage(message: 'jooooooo'));
                    },
                  ),
                  StandardButton(
                    child: Text('Logout'),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationLoggedOut(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
