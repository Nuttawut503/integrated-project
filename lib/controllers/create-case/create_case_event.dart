part of 'create_case_bloc.dart';

abstract class CreateCaseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TitleUpdated extends CreateCaseEvent {
  final String newTitle;

  TitleUpdated({@required this.newTitle});

  @override
  List<Object> get props => [newTitle];
}

class DetailUpdated extends CreateCaseEvent {
  final String newDetail;

  DetailUpdated({@required this.newDetail});

  @override
  List<Object> get props => [newDetail];
}

class TagAdded extends CreateCaseEvent {
  final String tagLabel;

  TagAdded({@required this.tagLabel});

  @override
  List<Object> get props => [tagLabel];
}

class TagRemoved extends CreateCaseEvent {
  final int index;

  TagRemoved({@required this.index});

  @override
  List<Object> get props => [index];
}

class CaseSubmitted extends CreateCaseEvent {}
