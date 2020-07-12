import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/controllers/messaging/messaging_bloc.dart';

class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MessagingBloc>(
      create: (context) => MessagingBloc(),
      child: Container(
        child: Text('MessagingScreen goes sring sring ', style: GoogleFonts.openSans(),),
      ),
    );
  }
}
