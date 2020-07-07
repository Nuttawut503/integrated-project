part of 'bottom_nav_bloc.dart';

class BottomNavInitial {
  int page = 0;
  BottomNavInitial({this.page});
}

@immutable
class BottomNavState {
  final int page;
  BottomNavState({@required this.page});
}
