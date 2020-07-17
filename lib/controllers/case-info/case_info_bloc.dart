import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'case_info_event.dart';
part 'case_info_state.dart';

class CaseInfoBloc extends Bloc<CaseInfoEvent, CaseInfoState> {
  final String _caseId;

  CaseInfoBloc({@required String caseId})
    : _caseId = caseId,
      super(CaseInfoInitialState());

  @override
  Stream<CaseInfoState> mapEventToState(
    CaseInfoEvent event,
  ) async* {
    yield CaseInfoInitialState();
  }
}
