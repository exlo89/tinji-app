import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinji/blocs/authentication/authentication_bloc.dart';
import 'package:tinji/blocs/matches/matches_bloc.dart';
import 'package:tinji/blocs/messenger/messenger_bloc.dart';
import 'package:tinji/models/tinji_match.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/repositories/match_repository.dart';
import 'package:tinji/screens/profile.dart';
import 'package:tinji/utils/storage.dart';

class Matches extends StatefulWidget {
  static final route = 'matches';

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  MatchesBloc _matchesBloc;

  @override
  void didChangeDependencies() {
    _matchesBloc = MatchesBloc(matchRepository: MatchRepository());

    // trigger app start event
    _matchesBloc.add(FetchedMatchUsers());

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _matchesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MatchesBloc>(
      create: (context) => _matchesBloc,
      child: BlocBuilder<MatchesBloc, MatchesState>(
        builder: (context, state) {
          print(state);
          Widget body = Center(
            child: CircularProgressIndicator(),
          );
          if (state is MatchesSuccess) {
            print(state.matches.length);
            body = ListView.builder(
              itemCount: state.matches.length,
              itemBuilder: (context, index) {
                TinjiMatch match = state.matches.elementAt(index);
                User matchedUser = match.host.id == Storage().user.id ? match.client : match.host;
                return ListTile(
                  title: Text(matchedUser.name + ', ' + matchedUser.age.toString()),
                  subtitle: Text(matchedUser.emoji1 +
                      ' ' +
                      matchedUser.emoji2 +
                      ' ' +
                      matchedUser.emoji3 +
                      ' ' +
                      matchedUser.emoji4),
                );
              },
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Matches'),
            ),
            body: body,
          );
        },
      ),
    );
  }
}
