import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {

  @override
  MessagingState get initialState => MessagingInitialState();

  @override
  Stream<MessagingState> mapEventToState(
    MessagingEvent event,
  ) async* {
    yield MessagingInitialState();
  }
}
