import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verify_user_event.dart';
part 'verify_user_state.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvent, VerifyUserState> {
  VerifyUserBloc() : super(VerifyUserInitial());

  @override
  Stream<VerifyUserState> mapEventToState(
    VerifyUserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
