import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc();

  @override
  BottomNavState get initialState => BottomNavState(page: 0);

  @override
  Stream<BottomNavState> mapEventToState(
    BottomNavEvent event,
  ) async* {
    if (event is InitialPage) {
      yield BottomNavState(page: 0);
    } else if (event is GetPage) {
      yield* _changePage(event);
    }
  }

  Stream<BottomNavState> _changePage(GetPage event) async* {
    yield BottomNavState(page: event.page);
  }
}
