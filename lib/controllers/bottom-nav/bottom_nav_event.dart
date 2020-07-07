part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();
  @override
  List<Object> get props => [];
}

class InitialPage extends BottomNavEvent {}

class GetPage extends BottomNavEvent {
  final int page;
  const GetPage({this.page});
  @override
  List<Object> get props => [page];
}
