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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Personal Information',
                style: GoogleFonts.openSans(fontSize: 28.0),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('${_currentUser['photo_url']}'),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${_currentUser['name']}',
                      style: GoogleFonts.openSans(fontSize: 20),
                    ),
                    Text(
                      '${_currentUser['email']}',
                      style: GoogleFonts.openSans(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            // Text('$_currentUser'),

            // Text(
            //   'Phone',
            //   style: GoogleFonts.openSans(fontSize: 20),
            // ),
            // SizedBox(height: 5),
            // Text(
            //   '${_currentUser['phone']}',
            //   style: GoogleFonts.openSans(fontSize: 15),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   'Address',
            //   style: GoogleFonts.openSans(fontSize: 20),
            // ),
            // SizedBox(height: 5),
            // Text(
            //   '${_currentUser['address']}',
            //   style: GoogleFonts.openSans(fontSize: 15),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   'Occupation',
            //   style: GoogleFonts.openSans(fontSize: 20),
            // ),
            // SizedBox(height: 5),
            // Text(
            //   '${_currentUser['occupation']}',
            //   style: GoogleFonts.openSans(fontSize: 15),
            // ),
            // SizedBox(height: 10),

            SizedBox(height: 30.0),
            Table(
              children: <TableRow>[
                TableRow(children: [
                  Text('Name:',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                  Text('${_currentUser['name']}',
                      style: GoogleFonts.openSans()),
                ]),
                TableRow(children: [
                  Text('Occupation:',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                  Text('${_currentUser['occupation']}',
                      style: GoogleFonts.openSans()),
                ]),
                TableRow(children: [
                  Text('Email:',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                  Text('${_currentUser['email']}',
                      style: GoogleFonts.openSans()),
                ]),
                TableRow(children: [
                  Text('Phone:',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                  Text('${_currentUser['phone']}',
                      style: GoogleFonts.openSans()),
                ]),
                // TableRow(children: [
                //   Text('Lawyer:',
                //       style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                //   Text('${_currentUser['is_lawyer'] ? 'YES' : 'NO'}',
                //       style: GoogleFonts.openSans()),
                // ]),
                TableRow(children: [
                  Text('Address:',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                  Text('${_currentUser['address']}',
                      style: GoogleFonts.openSans()),
                ]),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
            Center(
              child: FlatButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
