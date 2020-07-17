part of 'case_info_bloc.dart';

abstract class CaseInfoState extends Equatable {
  const CaseInfoState();

  @override
  List<Object> get props => [];
}

class CaseInfoUninitalized extends CaseInfoState {}

class CaseInfoLoaded extends CaseInfoState {
  final String title, detail, ownerId, lawyerAssistId, submittedDate;
  final List tags;

  CaseInfoLoaded({
    @required this.title,
    @required this.detail,
    @required this.ownerId,
    @required this.lawyerAssistId,
    @required this.submittedDate,
    @required this.tags,
  });

  @override
  List<Object> get props => [title, detail, ownerId, lawyerAssistId, submittedDate, tags];

  @override
  String toString() {
    return '''{
      'title': $title,
      'detail': $detail,
      'tags': $tags,
      'submitted_date': $submittedDate,
      'owner_id': $ownerId,
      'lawyer_assist_id': $lawyerAssistId,
    }''';
  }
}
