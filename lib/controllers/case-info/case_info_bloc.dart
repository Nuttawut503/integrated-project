import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'case_info_event.dart';
part 'case_info_state.dart';

class CaseInfoBloc extends Bloc<CaseInfoEvent, CaseInfoState> {

  @override
  CaseInfoState get initialState => CaseInfoInitialState();

  @override
  Stream<CaseInfoState> mapEventToState(
    CaseInfoEvent event,
  ) async* {
    yield CaseInfoInitialState();
  }
}
