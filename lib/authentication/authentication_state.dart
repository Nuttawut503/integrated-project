part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final Map currentUser;

  const Authenticated(this.currentUser);

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() {
    return '''Authenticated { 
      id: ${currentUser['id']},
      citizen_id: ${currentUser['citizen_id']},
      name: ${currentUser['name']},
      email: ${currentUser['email']},
      phone: ${currentUser['phone']},
      occupation: ${currentUser['occupation']},
      photo_url: ${currentUser['photo_url']},
      address: ${currentUser['address']},
      verified: ${currentUser['verified']},
      is_lawyer: ${currentUser['is_lawyer']},
    }\n''';
  }
}

class Unauthenticated extends AuthenticationState {}
