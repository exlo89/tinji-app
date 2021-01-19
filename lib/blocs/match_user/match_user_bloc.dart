import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinji/models/match_user.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/repositories/match_repository.dart';
import 'package:tinji/utils/storage.dart';

part 'match_user_event.dart';

part 'match_user_state.dart';

class MatchUserBloc extends Bloc<MatchUserEvent, MatchUserState> {
  final MatchRepository matchRepository;

  MatchUserBloc({@required this.matchRepository})
      : assert(matchRepository != null),
        super(MatchUserInitial());

  @override
  Stream<MatchUserState> mapEventToState(
    MatchUserEvent event,
  ) async* {
    if (event is FetchedMatchUsers) {
      yield MatchUserInProgress();
      List<User> matchUsers = await matchRepository.fetchMatchUser();
      Storage().matchUsers = matchUsers;
      yield MatchUserSuccess(matchUsers: matchUsers);
    }
  }
}
