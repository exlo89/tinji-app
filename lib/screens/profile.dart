import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/blocs/authentication/authentication_bloc.dart';
import 'package:tinji/blocs/messenger/messenger_bloc.dart';

class Profile extends StatefulWidget {
  static final route = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Builder(
        builder: (context) {
          return Container(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationLoggedOut(),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Snackbar'),
                  onTap: () {
                    BlocProvider.of<MessengerBloc>(context).add(MessengerSentErrorMessage(message: 'jooooooo', context: context));
                    //BlocProvider.of<MessengerBloc>(context).add(MessengerSentSuccessMessage(message: 'jaaa', context: context));
                    //BlocProvider.of<MessengerBloc>(context).add(MessengerSentSuccessMessage(message: 'uff', context: context));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
