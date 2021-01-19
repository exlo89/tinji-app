import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinji/models/tinji_match.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/repositories/match_repository.dart';
import 'package:tinji/utils/storage.dart';

part 'matches_event.dart';

part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final MatchRepository matchRepository;

  MatchesBloc({@required this.matchRepository})
      : assert(matchRepository != null),
        super(MatchesInitial());

  @override
  Stream<MatchesState> mapEventToState(
    MatchesEvent event,
  ) async* {
    if (event is FetchedMatchUsers) {
      yield MatchesInProgress();
      List<TinjiMatch> matches = await matchRepository.getMatches();
      Storage().matches = matches;
      yield MatchesSuccess(matches: matches);
    }
  }
}
