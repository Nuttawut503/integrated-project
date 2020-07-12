part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class UserInfoUpdated extends AuthenticationEvent {
  final FirebaseUser constInfo;
  final Map editableInfo;

  const UserInfoUpdated({@required this.constInfo, @required this.editableInfo});

  @override
  List<Object> get props => [constInfo, editableInfo];
}

class LoggedOut extends AuthenticationEvent {}
