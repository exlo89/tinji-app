part of 'messenger_bloc.dart';

@immutable
abstract class MessengerEvent extends Equatable {
  const MessengerEvent();

  @override
  List<Object> get props => [];
}

class MessengerSentSuccessMessage extends MessengerEvent {
  final String message;
  final BuildContext context;

  const MessengerSentSuccessMessage({this.message, this.context})
      : assert(message != null),
        assert(context != null);

  @override
  List<Object> get props => [message,context];
}

class MessengerSentErrorMessage extends MessengerEvent {
  final String message;
  final BuildContext context;

  const MessengerSentErrorMessage({this.message, this.context})
      : assert(message != null),
        assert(context != null);

  @override
  List<Object> get props => [message,context];
}
