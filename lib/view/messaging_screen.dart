import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LAWTALK/controllers/messaging/messaging_bloc.dart';

class MessagingScreen extends StatelessWidget {
  final String _caseId, _userId;

  MessagingScreen({Key key, @required String caseId, @required String userId})
    : _caseId = caseId,
      _userId = userId,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MessagingBloc>(
      create: (context) => MessagingBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('はあちゃまっちゃま～', style: GoogleFonts.openSans()),),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  child: ListView(
                    reverse: true,
                    children: <Widget>[
                      for (int i = 19; i >= 0; --i)
                        ChatBox(isMine: (new Random()).nextBool(), order: i+1)
                    ],
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Material(
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.black.withOpacity(0.3),
                        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(FontAwesomeIcons.solidImage, size: 22.0, color: Colors.blue[600],),
                        ),
                      )
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.0),
                        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: TextField(
                          style: GoogleFonts.openSans(fontSize: 19.0),
                          decoration: InputDecoration.collapsed(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(19),
                              borderSide: BorderSide(
                                width: 0, 
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Type your message...',
                            hintStyle: GoogleFonts.openSans(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.black.withOpacity(0.3),
                        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(FontAwesomeIcons.paperPlane, size: 22.0, color: Colors.blue[600],),
                        ),
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBox extends StatelessWidget {
  final bool isMine;
  final int order;

  ChatBox({@required this.isMine, @required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMine? MainAxisAlignment.end: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: isMine? Colors.blue[600]: Colors.grey[300],
          ),
          child: Text('Hello World ($order)', style: GoogleFonts.openSans(color: isMine? Colors.white: Colors.black)),
        )
      ],
    );
  }
}
