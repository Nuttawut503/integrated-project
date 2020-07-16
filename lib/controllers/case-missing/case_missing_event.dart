part of 'case_missing_bloc.dart';

abstract class MissingCasesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MissingCasesLoadingStarted extends MissingCasesEvent {}

class MissingCasesUpdated extends MissingCasesEvent {
  final List<Map> cases;

  MissingCasesUpdated({@required this.cases});

  @override
  List<Object> get props => [cases]; 
}
