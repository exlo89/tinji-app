part of 'messenger_bloc.dart';

@immutable
abstract class MessengerEvent extends Equatable {
  const MessengerEvent();

  @override
  List<Object> get props => [];
}

class MessengerSendMessage extends MessengerEvent {
  final String message;

  const MessengerSendMessage({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
