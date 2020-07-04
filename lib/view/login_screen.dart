import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LAWTALK/api/user_repository.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: _LoginContent(),
        ),
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: state.isSubmitting
                ? null
                : () {
                  BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
                },
              child: Text(
                'Sign in with Google', 
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0,),
              ),
              color: Color.fromRGBO(234, 67, 53, 1.0)
            ),
            if (state.isSubmitting)
              Text('Authenticating...', style: GoogleFonts.openSans(color: Colors.orange, fontSize: 12.0),)
            else if (state.isSuccess)
              Text('Sucessed, switching the screen...', style: GoogleFonts.openSans(color: Colors.green, fontSize: 12.0),)
            else if (state.isFailure)
              Text('Failed to get the information', style: GoogleFonts.openSans(color: Colors.red, fontSize: 12.0),)
            else
              Text('', style: GoogleFonts.openSans(fontSize: 12.0),)
          ]
        ),
      ),
    );
  }
}
