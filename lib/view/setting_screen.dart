import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/setting/setting_bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (context) => SettingBloc(),
      child: Container(
        child: Column(
          children: <Widget>[
            Text('SettingScreen goes sring sring ', style: GoogleFonts.openSans(),),
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
