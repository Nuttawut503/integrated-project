import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            child: Text('Hello World', style: GoogleFonts.openSans(color: Colors.white),),
          ),
        ),
      ),
      onWillPop: () async {
        return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?', style: GoogleFonts.openSans()),
            content: Text('Do you want to exit the app', style: GoogleFonts.openSans()),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: GoogleFonts.openSans()),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes', style: GoogleFonts.openSans()),
              ),
            ],
          ),
        )) ?? false;
      },
    );
  }
}
