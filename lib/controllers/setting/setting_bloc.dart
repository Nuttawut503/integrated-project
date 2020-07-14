import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {

  SettingBloc(): super(SettingInitialState());
  
  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    yield SettingInitialState();
  }
}
