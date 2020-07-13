import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';

class LawyerVerifyScreen extends StatefulWidget {
  final Map _currentUser;

  LawyerVerifyScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _LawyerVerifyScreenState createState() => _LawyerVerifyScreenState();
}

class _LawyerVerifyScreenState extends State<LawyerVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Haha this page goes bruh bruh',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                  )),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'Verify as regular user',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                color: Colors.pinkAccent,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'Verify as lawyer',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                color: Colors.indigoAccent,
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
                child: Text(
                  'Sign out',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
