import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';

class VerifyScreen extends StatefulWidget {
  final Map _currentUser;

  VerifyScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Haha this page goes bruh bruh', style: GoogleFonts.openSans(color: Colors.white,)),
            SizedBox(height: 16.0,),
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
    );
  }
}