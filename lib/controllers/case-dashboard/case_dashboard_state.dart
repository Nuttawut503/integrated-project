part of 'case_dashboard_bloc.dart';

@override
class CaseDashboardState {
  final bool createdCaseLoaded;
  final bool joinedCaseLoaded;
  final List<Map> createdCases;
  final List<Map> joinedCases;
  final bool activeFiltered;

  CaseDashboardState({
    @required this.createdCaseLoaded,
    @required this.joinedCaseLoaded,
    @required this.createdCases,
    @required this.joinedCases,
    @required this.activeFiltered,
  });

  factory CaseDashboardState.empty() {
    return CaseDashboardState(
      createdCaseLoaded: false,
      joinedCaseLoaded: false,
      createdCases: [],
      joinedCases: [],
      activeFiltered: false,
    );
  }

  CaseDashboardState updateCreatedCases({
    @required List<Map> createdCases,
  }) {
    return _copyWith(
      createdCaseLoaded: true,
      createdCases: createdCases
    );
  }

  CaseDashboardState updateJoinedCases({
    @required List<Map> joinedCases,
  }) {
    return _copyWith(
      joinedCaseLoaded: true,
      joinedCases: joinedCases
    );
  }

  CaseDashboardState toggleFilter() {
    return _copyWith(
      activeFiltered: this.activeFiltered ^ true
    );
  }

  List<Map> waitingCases() {
    return this.createdCases.where((c) => c['lawyer_assist_id'] == null).toList();
  }

  List<Map> activeCases() {
    return this.createdCases.where((c) => c['lawyer_assist_id'] != null).toList() + this.joinedCases;
  }

  List<Map> filteredCases() {
    List<Map> mergedCases = this.activeFiltered? this.activeCases(): this.waitingCases();
    mergedCases.sort((Map a, Map b) {
      DateTime atime = a['submitted_date_raw'], btime = b['submitted_date_raw'];
      return btime.compareTo(atime);
    });
    return mergedCases;
  }

  CaseDashboardState _copyWith({
    bool createdCaseLoaded,
    bool joinedCaseLoaded,
    List<Map> createdCases,
    List<Map> joinedCases,
    bool activeFiltered,
  }) {
    return CaseDashboardState(
      createdCaseLoaded: createdCaseLoaded ?? this.createdCaseLoaded,
      joinedCaseLoaded: joinedCaseLoaded ?? this.joinedCaseLoaded,
      createdCases: createdCases ?? this.createdCases,
      joinedCases: joinedCases ?? this.joinedCases,
      activeFiltered: activeFiltered ?? this.activeFiltered,
    );
  }

  @override
  String toString() {
    return '''{
      'createdCaseLoaded': $createdCaseLoaded,
      'joinedCaseLoaded': $joinedCaseLoaded,
      'createdCasesNumber': ${createdCases.length},
      'joinedCasesNumber': ${joinedCases.length},
      'activeFiltered': $activeFiltered,
    }''';
  }
}
