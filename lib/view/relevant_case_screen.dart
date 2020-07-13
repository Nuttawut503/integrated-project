import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/controllers/relevant-case/relevant_case_bloc.dart';

class RelevantCaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RelevantCaseBloc>(
      create: (context) => RelevantCaseBloc(),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(229, 229, 255, 1.0),
          image: DecorationImage(image: AssetImage('images/shinobu.jpg'), fit: BoxFit.cover),
        ),
        child: Text('RelevantCaseScreen goes sring sring ', style: GoogleFonts.openSans(),),
      ),
    );
  }
}
