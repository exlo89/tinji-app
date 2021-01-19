part of 'match_user_bloc.dart';

@immutable
abstract class MatchUserState extends Equatable {
  const MatchUserState();

  @override
  List<Object> get props => [];
}

class MatchUserInitial extends MatchUserState {}

class MatchUserSuccess extends MatchUserState {
  final List<User> matchUsers;

  const MatchUserSuccess({this.matchUsers});

  @override
  List<Object> get props => [matchUsers];
}

class MatchUserFailure extends MatchUserState {}

class MatchUserInProgress extends MatchUserState {}


