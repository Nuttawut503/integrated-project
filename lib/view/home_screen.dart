import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          child: Text('Hello World ${_currentUser['name']}', style: GoogleFonts.openSans(color: Colors.white),),
        ),
      ),
    );
  }
}
