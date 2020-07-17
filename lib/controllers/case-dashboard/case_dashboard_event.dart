part of 'case_dashboard_bloc.dart';

abstract class CaseDashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingRequested extends CaseDashboardEvent {}

class CreatedCasesUpdated extends CaseDashboardEvent {
  final List<Map> createdCases;

  CreatedCasesUpdated({@required this.createdCases});

  @override
  List<Object> get props => [createdCases];
}

class JoinedCasesUpdated extends CaseDashboardEvent {
  final List<Map> joinedCases;

  JoinedCasesUpdated({@required this.joinedCases});

  @override
  List<Object> get props => [joinedCases];
}

class FilterToggled extends CaseDashboardEvent {}
