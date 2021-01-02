import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'messenger_event.dart';

part 'messenger_state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  MessengerBloc() : super(MessengerInitial());

  @override
  Stream<MessengerState> mapEventToState(
    MessengerEvent event,
  ) async* {
    if (event is MessengerSentSuccessMessage) {
      Scaffold.of(event.context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(event.message),
          duration: Duration(seconds: 3),
        ),
      );
    }

    if (event is MessengerSentErrorMessage) {
      Scaffold.of(event.context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(event.message),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
