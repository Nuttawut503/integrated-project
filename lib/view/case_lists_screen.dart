import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LAWTALK/controllers/case-lists/case_lists_bloc.dart';
import 'package:LAWTALK/view/create_case_screen.dart';

class CaseListsScreen extends StatelessWidget {
  final String _currentUserId;

  CaseListsScreen({Key key, @required String currentUserId})
      : _currentUserId = currentUserId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CaseListsBloc>(
      create: (context) => CaseListsBloc(),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(229, 229, 255, 1.0),
              image: DecorationImage(image: AssetImage('images/shinobu.jpg'), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CaseLists(),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: CreateNewCaseButton(
              currentUserId: _currentUserId,
            ),
          )
        ],
      )
    );
  }
}

class CaseLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 8.0),
        for (int i = 0; i < 100; ++i)
          Text('はあちゃまっちゃま～', style: GoogleFonts.openSans(),)
      ],
    );
  }
}

class CreateNewCaseButton extends StatelessWidget {
  final String _currentUserId;
  
  CreateNewCaseButton({Key key, @required String currentUserId})
      : _currentUserId = currentUserId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateCaseScreen(
                currentUserId: _currentUserId,
              )
            )
          );
        },
        splashColor: Colors.black.withOpacity(0.3),
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Icon(FontAwesomeIcons.plus, size: 26.0,),
        ),
      )
    );
  }
}
