import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'case_lists_event.dart';
part 'case_lists_state.dart';

class CaseListsBloc extends Bloc<CaseListsEvent, CaseListsState> {

  @override
  CaseListsState get initialState => CaseListsInitialState();

  @override
  Stream<CaseListsState> mapEventToState(
    CaseListsEvent event,
  ) async* {
    yield CaseListsInitialState();
  }
}
