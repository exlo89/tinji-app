import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'messenger_event.dart';

part 'messenger_state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  BehaviorSubject<String> _subjectMessenger = BehaviorSubject<String>();

  MessengerBloc() : super(MessengerInitial());

  ValueStream<String> get messengerObservable => _subjectMessenger.stream;

  @override
  Stream<MessengerState> mapEventToState(
    MessengerEvent event,
  ) async* {
    if (event is MessengerSendMessage) {
      print(event.message);
    }
    print(event);
    _subjectMessenger.sink.add('Test');
  }


  @override
  Future<void> close() {
    _subjectMessenger.close();
    super.close();
  }
}
