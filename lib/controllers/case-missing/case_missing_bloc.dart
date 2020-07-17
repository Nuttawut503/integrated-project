import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:LAWTALK/api/case_repository.dart';

part 'case_missing_event.dart';
part 'case_missing_state.dart';

class MissingCasesBloc extends Bloc<MissingCasesEvent, MissingCasesState> {
  final String _userId;
  final CaseRepository _caseRepository;
  StreamSubscription _caseSubscription;

  MissingCasesBloc({@required String userId})
    : _userId = userId,
      _caseRepository = CaseRepository(),
      super(MissingCasesInitialState());

  @override
  Stream<MissingCasesState> mapEventToState(
    MissingCasesEvent event,
  ) async* {
    if (event is MissingCasesLoadingStarted) {
      yield* _mapMissingCasesLoadingStartedToState();
    } else if (event is MissingCasesUpdated) {
      yield* _mapMissingCasesUpdatedToState(event.cases);
    }
  }

  Stream<MissingCasesState> _mapMissingCasesLoadingStartedToState() async* {
    _caseSubscription?.cancel();
    _caseSubscription = _caseRepository.getAllOtherCases()
                        .listen((missingCases) {
                          add(MissingCasesUpdated(cases: missingCases.where((c) => c['owner_id'] != _userId).toList()));
                        });
  }

  Stream<MissingCasesState> _mapMissingCasesUpdatedToState(List<Map> updatedCases) async* {
    yield MissingCasesLoaded(missingCases: updatedCases);
  }

  @override
  Future<void> close() {
    _caseSubscription?.cancel();
    return super.close();
  }
}
