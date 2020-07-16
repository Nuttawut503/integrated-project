import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/create-case/create_case_bloc.dart';

class CreateCaseScreen extends StatelessWidget {
  final String _currentUserId;
  
  CreateCaseScreen({Key key, @required String currentUserId})
      : _currentUserId = currentUserId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pop();
        }
      },
      child: BlocProvider<CreateCaseBloc>(
        create: (context) => CreateCaseBloc(userId: _currentUserId),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: CreateCase()
          ),
        ),
      ),
    );
  }
}

class CreateCase extends StatefulWidget {
  @override
  _CreateCaseState createState() => _CreateCaseState();
}

class _CreateCaseState extends State<CreateCase> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('CreateCaseScreen goes sring sring ', style: GoogleFonts.openSans(),),
      ],
    );
  }
}