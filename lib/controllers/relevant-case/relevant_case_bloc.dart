import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'relevant_case_event.dart';
part 'relevant_case_state.dart';

class RelevantCaseBloc extends Bloc<RelevantCaseEvent, RelevantCaseState> {

  RelevantCaseBloc(): super(RelevantCaseInitialState());
  
  @override
  Stream<RelevantCaseState> mapEventToState(
    RelevantCaseEvent event,
  ) async* {
    yield RelevantCaseInitialState();
  }
}
