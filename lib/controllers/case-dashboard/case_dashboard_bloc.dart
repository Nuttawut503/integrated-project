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
  StreamSubscription _createdCasesSubscription, _joinedCasesSubscription;

  CaseDashboardBloc({@required String userId})
    : _userId = userId,
      _caseRepository = CaseRepository(),
      super(CaseDashboardState.empty());
  
  @override
  Stream<CaseDashboardState> mapEventToState(
    CaseDashboardEvent event,
  ) async* {
    if (event is LoadingRequested) {
      yield* _mapLoadingRequestedToState();
    } else if (event is CreatedCasesUpdated) {
      yield* _mapCreatedCasesUpdatedToState(createdCases: event.createdCases);
    } else if (event is JoinedCasesUpdated) {
      yield* _mapJoinedCasesUpdatedToState(joinedCases: event.joinedCases);
    } else if (event is FilterToggled) {
      yield* _mapFilterToggledToState();
    }
  }

  Stream<CaseDashboardState> _mapLoadingRequestedToState() async* {
    _createdCasesSubscription?.cancel();
    _joinedCasesSubscription?.cancel();
    _createdCasesSubscription = _caseRepository.getMyCases(userId: _userId)
                        .listen((createdCases) {
                          add(CreatedCasesUpdated(createdCases: createdCases));
                        });
    _joinedCasesSubscription = _caseRepository.getRelevantCases(userId: _userId)
                        .listen((joinedCases) {
                          add(JoinedCasesUpdated(joinedCases: joinedCases));
                        });
  }

  Stream<CaseDashboardState> _mapCreatedCasesUpdatedToState({@required List<Map> createdCases}) async* {
    yield state.updateCreatedCases(createdCases: createdCases);
  }

  Stream<CaseDashboardState> _mapJoinedCasesUpdatedToState({@required List<Map> joinedCases}) async* {
    yield state.updateJoinedCases(joinedCases: joinedCases);
  }

  Stream<CaseDashboardState> _mapFilterToggledToState() async* {
    yield state.toggleFilter();
  }

  @override
  Future<void> close() {
    _createdCasesSubscription?.cancel();
    _joinedCasesSubscription?.cancel();
    return super.close();
  }
}
