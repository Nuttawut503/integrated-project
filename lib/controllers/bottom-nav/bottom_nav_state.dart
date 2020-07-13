part of 'bottom_nav_bloc.dart';

@immutable
class BottomNavState {
  final int currentPage;

  BottomNavState({@required this.currentPage});

  @override
  String toString() {
    return '''BottomNavPage { currentPage: $currentPage }\n''';
  }
}
