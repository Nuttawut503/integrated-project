import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/case-info/case_info_bloc.dart';

class CaseInfoScreen extends StatelessWidget {
  final String _caseId;

  CaseInfoScreen({Key key, @required String caseId})
    : _caseId = caseId,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
      child: BlocProvider<CaseInfoBloc>(
        create: (context) => CaseInfoBloc(caseId: _caseId),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              child: Text('CaseInfoScreen goes sring sring ', style: GoogleFonts.openSans(),),
            ),
          ),
        ),
      ),
    );
  }
}
