import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/controllers/case-info/case_info_bloc.dart';

class CaseInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CaseInfoBloc>(
      create: (context) => CaseInfoBloc(),
      child: Container(
        child: Text('CaseInfoScreen goes sring sring ', style: GoogleFonts.openSans(),),
      ),
    );
  }
}
