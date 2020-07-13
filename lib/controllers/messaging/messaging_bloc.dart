import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {

  MessagingBloc(): super(MessagingInitialState());

  @override
  Stream<MessagingState> mapEventToState(
    MessagingEvent event,
  ) async* {
    yield MessagingInitialState();
  }
}
