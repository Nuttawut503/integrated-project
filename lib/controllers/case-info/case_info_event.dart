part of 'case_info_bloc.dart';

abstract class CaseInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InfoLoadingRequested extends CaseInfoEvent {}

class InfoChanged extends CaseInfoEvent {
  final Map newInfo;

  InfoChanged({@required this.newInfo});

  @override
  List<Object> get props => [newInfo];
}

class CaseAccepted extends CaseInfoEvent {
  final String userId;

  CaseAccepted({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class CaseDeleted extends CaseInfoEvent {}
