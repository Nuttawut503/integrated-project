import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'create_case_event.dart';
part 'create_case_state.dart';

class CreateCaseBloc extends Bloc<CreateCaseEvent, CreateCaseState> {
  final String _userId;

  CreateCaseBloc({@required String userId})
    : _userId = userId,
      super(CreateCaseInitialState());

  @override
  Stream<CreateCaseState> mapEventToState(
    CreateCaseEvent event,
  ) async* {
    yield CreateCaseInitialState();
  }
}
