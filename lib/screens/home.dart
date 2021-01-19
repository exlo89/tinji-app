import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/blocs/match_user/match_user_bloc.dart';
import 'package:tinji/models/match_user.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/repositories/match_repository.dart';
import 'package:tinji/screens/matches.dart';
import 'package:tinji/screens/profile.dart';
import 'package:tinji/utils/storage.dart';

class Home extends StatefulWidget {
  static final route = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MatchUserBloc _matchUserBloc;

  @override
  void didChangeDependencies() {
    _matchUserBloc = MatchUserBloc(matchRepository: MatchRepository());

    // trigger app start event
    _matchUserBloc.add(FetchedMatchUsers());

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _matchUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MatchUserBloc>(
      create: (context) => _matchUserBloc,
      child: BlocBuilder<MatchUserBloc, MatchUserState>(
        builder: (context, state) {
          Widget body = Center(
            child: CircularProgressIndicator(),
          );
          if (state is MatchUserSuccess) {
            body = ListView.builder(
              itemCount: state.matchUsers.length,
              itemBuilder: (context, index) {
                User user = state.matchUsers.elementAt(index);
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.emoji1 + ' ' + user.emoji2 + ' ' + user.emoji3 + ' ' + user.emoji4),
                );
              },
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('tinji'),
              actions: [
                IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Matches.route);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Profile.route);
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      print('dislike');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      print('like');
                    },
                  ),
                ],
              ),
            ),
            body: body,
          );
        },
      ),
    );
  }
}
