part of 'case_missing_bloc.dart';

abstract class MissingCasesState extends Equatable {
  const MissingCasesState();

  @override
  List<Object> get props => [];
}

class MissingCasesInitialState extends MissingCasesState {}

class MissingCasesLoaded extends MissingCasesState {
  final List<Map> missingCases;

  MissingCasesLoaded({@required this.missingCases});

  @override
  List<Object> get props => [missingCases];

  @override
  String toString() {
    return '''{ missingCasesNumber: ${missingCases.length} }''';
  }
}
