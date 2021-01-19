part of 'matches_bloc.dart';

@immutable
abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object> get props => [];
}

class FetchedMatchUsers extends MatchesEvent {}
