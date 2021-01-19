part of 'matches_bloc.dart';

@immutable
abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object> get props => [];
}

class MatchesInitial extends MatchesState {}

class MatchesSuccess extends MatchesState {
  final List<TinjiMatch> matches;

  const MatchesSuccess({this.matches});

  @override
  List<Object> get props => [matches];
}

class MatchesFailure extends MatchesState {}

class MatchesInProgress extends MatchesState {}


