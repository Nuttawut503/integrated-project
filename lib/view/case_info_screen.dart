import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/case-info/case_info_bloc.dart';
import 'package:LAWTALK/view/messaging_screen.dart';

class CaseInfoScreen extends StatelessWidget {
  final String _caseId, _currentUserId;

  CaseInfoScreen({Key key, @required String caseId, @required String currentUserId})
    : _caseId = caseId,
      _currentUserId = currentUserId,
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
        create: (context) => CaseInfoBloc(caseId: _caseId)..add(InfoLoadingRequested()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: CaseInfo(
                caseId: _caseId,
                currentUserId: _currentUserId,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CaseInfo extends StatelessWidget {
  final String _caseId, _currentUserId;

  CaseInfo({Key key, @required String caseId, @required String currentUserId})
    : _caseId = caseId,
      _currentUserId = currentUserId,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaseInfoBloc, CaseInfoState>(
      listener: (context, state) {
        if (state is CaseInfoLoaded && state.title == null) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is CaseInfoLoaded) {
          return ListView(
            children: <Widget>[
              Text('${state.title}', style: GoogleFonts.openSans(fontSize: 29.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.0,),
              Text('${state.submittedDate}', style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w300)),
              SizedBox(height: 20.0,),
              Text('${state.detail}', style: GoogleFonts.openSans()),
              SizedBox(height: 16.0,),
              Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 6.0,
                children: [
                  for (String tag in state.tags)
                    Padding(
                      padding: EdgeInsets.only(left: 9.0),
                      child: Badge(
                        badgeColor: Color.fromRGBO(166, 200, 200, 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
                        shape: BadgeShape.square,
                        borderRadius: 13,
                        toAnimate: false,
                        badgeContent: Text('$tag', style: GoogleFonts.openSans(color: Colors.black)),
                      ),
                    )
                ],  
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (state.lawyerAssistId != null &&(state.ownerId == _currentUserId || state.lawyerAssistId == _currentUserId))
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MessagingScreen(
                              caseId: _caseId,
                              userId: _currentUserId,
                            )
                          )
                        );
                      },
                      child: Text(
                        'Start chatting', 
                        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0,),
                      ),
                      color: Colors.blue
                    ),
                  if (state.lawyerAssistId == null && state.ownerId != _currentUserId)
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<CaseInfoBloc>(context).add(CaseAccepted(userId: _currentUserId));
                      },
                      child: Text(
                        'Accept this case', 
                        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0,),
                      ),
                      color: Colors.green
                    ),
                  if (state.lawyerAssistId == null && state.ownerId == _currentUserId)
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<CaseInfoBloc>(context).add(CaseDeleted());
                      },
                      child: Text(
                        'Delete this case',
                        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0,),
                      ),
                      color: Colors.red
                    ),
                ],
              )
            ],
          );
        }
        return Text('Loading Info...', style: GoogleFonts.openSans(),);
      },
    );
  }
}