import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:LAWTALK/api/case_repository.dart';

part 'case_dashboard_event.dart';
part 'case_dashboard_state.dart';

class CaseDashboardBloc extends Bloc<CaseDashboardEvent, CaseDashboardState> {
  final String _userId;
  final CaseRepository _caseRepository;

  CaseDashboardBloc({@required String userId})
    : _userId = userId,
      _caseRepository = CaseRepository(),
      super(CaseDashboardInitialState());
  
  @override
  Stream<CaseDashboardState> mapEventToState(
    CaseDashboardEvent event,
  ) async* {
    yield CaseDashboardInitialState();
  }
}
