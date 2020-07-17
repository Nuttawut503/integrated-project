import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:LAWTALK/api/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  StreamSubscription _userSubscription;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is UserInfoUpdated) {
      yield* _mapUserInfoUpdatedToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      add(LoggedIn());
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    FirebaseUser constInfo = await _userRepository.getConstUserInfo();
    _userSubscription?.cancel();
    _userSubscription = _userRepository
        .getEditableUserInfo(constInfo.uid)
        .listen((editableInfo) => add(UserInfoUpdated(
            constInfo: constInfo,
            editableInfo: editableInfo.exists ? editableInfo.data : Map())));
  }

  Stream<AuthenticationState> _mapUserInfoUpdatedToState(
      UserInfoUpdated user) async* {
    yield Authenticated({
      'id': user.constInfo.uid,
      'email': user.constInfo.email,
      'photo_url': user.constInfo.photoUrl,
      'citizen_id': user.editableInfo['citizenId'],
      'name':
          '${user.editableInfo['first_name'] ?? ''} ${user.editableInfo['last_name'] ?? ''}',
      'verified': user.editableInfo['isVerified'] ?? false,
      'is_lawyer': user.editableInfo['isLawyer'] ?? false,
      'phone': user.editableInfo['phone'] ?? '',
      'address': user.editableInfo['address'] ?? '',
      'occupation': user.editableInfo['occupation'] ?? '',
    });
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
