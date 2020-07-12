import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/controllers/case-lists/case_lists_bloc.dart';

class CaseListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CaseListsBloc>(
      create: (context) => CaseListsBloc(),
      child: Container(
        child: Text('CaseListsScreen goes sring sring ', style: GoogleFonts.openSans(),),
      ),
    );
  }
}
