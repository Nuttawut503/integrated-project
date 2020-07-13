part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();
  @override
  List<Object> get props => [];
}

class PageIndexUpdated extends BottomNavEvent {
  final int pageNumber;

  const PageIndexUpdated({@required this.pageNumber});
  
  @override
  List<Object> get props => [pageNumber];
}
