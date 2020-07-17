import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:LAWTALK/api/case_repository.dart';

part 'create_case_event.dart';
part 'create_case_state.dart';

class CreateCaseBloc extends Bloc<CreateCaseEvent, CreateCaseState> {
  final CaseRepository _caseRepository;
  final String _userId;

  CreateCaseBloc({@required String userId})
    : _caseRepository = CaseRepository(),
      _userId = userId,
      super(CreateCaseState.empty());

  @override
  Stream<CreateCaseState> mapEventToState(
    CreateCaseEvent event,
  ) async* {
    if (event is TitleUpdated) {
      yield* _mapTitleUpdatedToState(event.newTitle.trim());
    } else if (event is TagAdded) {
      yield* _mapTagAddedToState(event.tagLabel.trim());
    } else if (event is TagRemoved) {
      yield* _mapTagRemovedToState(event.index);
    } else if (event is CaseSubmitted) {
      yield* _mapCaseSubmittedToState(event.newDetail);
    }
  }

  Stream<CreateCaseState> _mapTitleUpdatedToState(String newTitle) async* {
    yield state.updateTitle(newTitle: newTitle);
  }
  Stream<CreateCaseState> _mapTagAddedToState(String tagLabel) async* {
    yield state.addTag(tagLabel: tagLabel);
  }

  Stream<CreateCaseState> _mapTagRemovedToState(int index) async* {
    yield state.removeTag(index: index);
  }

  Stream<CreateCaseState> _mapCaseSubmittedToState(String newDetail) async* {
    try {
      yield state.updateDetail(newDetail: newDetail).submit();
      await _caseRepository.addNewCase(
        userId: _userId,
        title: state.title,
        detail: newDetail.trim(),
        tags: state.tags,
      );
      yield state.updateDetail(newDetail: newDetail).success();
    } catch (_) {
      yield state.updateDetail(newDetail: newDetail).failure();
    }
  }
}
