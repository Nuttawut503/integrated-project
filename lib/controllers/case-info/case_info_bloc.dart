import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:LAWTALK/api/case_repository.dart';

part 'case_info_event.dart';
part 'case_info_state.dart';

class CaseInfoBloc extends Bloc<CaseInfoEvent, CaseInfoState> {
  final String _caseId;
  final CaseRepository _caseRepository;
  StreamSubscription _caseSubscription;

  CaseInfoBloc({@required String caseId})
    : _caseId = caseId,
      _caseRepository = CaseRepository(),
      super(CaseInfoUninitalized());

  @override
  Stream<CaseInfoState> mapEventToState(
    CaseInfoEvent event,
  ) async* {
    if (event is InfoLoadingRequested) {
      yield* _mapInfoLoadingRequestedToState();
    } else if (event is InfoChanged) {
      yield* _mapInfoChangedToState(event.newInfo);
    } else if (event is CaseAccepted) {
      yield* _mapCaseAcceptedToState(event.userId);
    } else if (event is CaseDeleted) {
      yield* _mapCaseDeletedToState();
    }
  }

  Stream<CaseInfoState> _mapInfoLoadingRequestedToState() async* {
    _caseSubscription?.cancel();
    _caseSubscription = _caseRepository.getInfoFromCase(caseId: _caseId).listen((info) => add(InfoChanged(newInfo: info)));
  }

  Stream<CaseInfoState> _mapInfoChangedToState(Map newInfo) async* {
    yield CaseInfoLoaded(
      title: newInfo['title'],
      detail: newInfo['detail'],
      ownerId: newInfo['owner_id'],
      lawyerAssistId: newInfo['lawyer_assist_id'],
      submittedDate: newInfo['submitted_date'],
      tags: newInfo['tags'],
    );
  }

  Stream<CaseInfoState> _mapCaseAcceptedToState(String userId) async* {
    await _caseRepository.updateLawyerAssistId(caseId: _caseId, lawyerId: userId);
  }

  Stream<CaseInfoState> _mapCaseDeletedToState() async* {
    await _caseRepository.deleteCase(caseId: _caseId);
  }

  @override
  Future<void> close() {
    _caseSubscription?.cancel();
    return super.close();
  }
}
