import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  final Map _currentUser;

  HomeScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Hello World ${_currentUser['name']}', style: GoogleFonts.openSans(color: Colors.white),),
              SizedBox(height: 16.0,),
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
                child: Text(
                  'Sign out',
                  style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0,),
                ),
                color: Colors.green,
              )
            ],
          )
        ),
      ),
    );
  }
}
