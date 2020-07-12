import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/controllers/create-case/create_case_bloc.dart';

class CreateCaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateCaseBloc>(
      create: (context) => CreateCaseBloc(),
      child: Container(
        child: Text('CreateCaseScreen goes sring sring ', style: GoogleFonts.openSans(),),
      ),
    );
  }
}
