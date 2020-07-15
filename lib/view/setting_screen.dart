import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/setting/setting_bloc.dart';

class SettingScreen extends StatelessWidget {
  final Map _currentUser;

  SettingScreen({Key key, @required Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (context) => SettingBloc(),
      child: Container(
        child: Column(
          children: <Widget>[
            Text('$_currentUser', style: GoogleFonts.openSans(),),
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
