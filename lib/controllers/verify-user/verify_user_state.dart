part of 'verify_user_bloc.dart';

abstract class VerifyUserState extends Equatable {
  const VerifyUserState();
}

class VerifyUserInitial extends VerifyUserState {
  @override
  List<Object> get props => [];
}

class PostDetails extends VerifyUserState {
  PostDetails();
}
