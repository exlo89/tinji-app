part of 'match_user_bloc.dart';

@immutable
abstract class MatchUserEvent extends Equatable {
  const MatchUserEvent();

  @override
  List<Object> get props => [];
}

class FetchedMatchUsers extends MatchUserEvent {}
