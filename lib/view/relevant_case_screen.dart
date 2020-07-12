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
        child: Text('RelevantCaseScreen goes sring sring ', style: GoogleFonts.openSans(),),
      ),
    );
  }
}
