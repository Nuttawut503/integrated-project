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
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Basic Information', style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 28.0),),
            SizedBox(height: 16.0),
            Table(
              children: <TableRow>[
                TableRow(
                  children: [
                    Text('Name:', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                    Text('${_currentUser['name']}', style: GoogleFonts.openSans()),
                  ]
                ),
                TableRow(
                  children: [
                    Text('Occupation:', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                    Text('${_currentUser['occupation']}', style: GoogleFonts.openSans()),
                  ]
                ),
                TableRow(
                  children: [
                    Text('Email:', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                    Text('${_currentUser['email']}', style: GoogleFonts.openSans()),
                  ]
                ),
                TableRow(
                  children: [
                    Text('Phone:', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                    Text('${_currentUser['phone']}', style: GoogleFonts.openSans()),
                  ]
                ),
                TableRow(
                  children: [
                    Text('Lawyer:', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                    Text('${_currentUser['is_lawyer']?'YES': 'NO'}', style: GoogleFonts.openSans()),
                  ]
                ),
              ],
            ),
            SizedBox(height: 32.0,),
            FlatButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              child: Text(
                'SIGN OUT',
                style: GoogleFonts.openSans(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
