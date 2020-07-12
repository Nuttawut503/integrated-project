import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'create_case_event.dart';
part 'create_case_state.dart';

class CreateCaseBloc extends Bloc<CreateCaseEvent, CreateCaseState> {

  @override
  CreateCaseState get initialState => CreateCaseInitialState();

  @override
  Stream<CreateCaseState> mapEventToState(
    CreateCaseEvent event,
  ) async* {
    yield CreateCaseInitialState();
  }
}
