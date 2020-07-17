import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Text('MessagingScreen (No implement yet)', style: GoogleFonts.openSans(),),
          ),
        ),
      ),
    );
  }
}
