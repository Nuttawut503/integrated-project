import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/case-dashboard/case_dashboard_bloc.dart';
import 'package:LAWTALK/view/create_case_screen.dart';
import 'package:LAWTALK/view/case_info_screen.dart';
import 'package:LAWTALK/view/messaging_screen.dart';

class CaseDashboardScreen extends StatelessWidget {
  final String _userId;

  CaseDashboardScreen({Key key, @required String userId})
    : _userId = userId,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pop();
        }
      },
      child: BlocProvider<CaseDashboardBloc>(
        create: (context) => CaseDashboardBloc(userId: _userId)..add(LoadingRequested()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: BlocBuilder<CaseDashboardBloc, CaseDashboardState>(
                builder: (context, state) {
                  return ListView(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('My Case', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.bold),),
                          SizedBox(width: 16.0),
                          CreateNewCaseButton(currentUserId: _userId),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (state.activeFiltered) BlocProvider.of<CaseDashboardBloc>(context).add(FilterToggled());
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 4.0),
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: (state.activeFiltered)? null: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Text('WAITING (${state.waitingCases().length})', style: GoogleFonts.openSans(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (!state.activeFiltered) BlocProvider.of<CaseDashboardBloc>(context).add(FilterToggled());
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 4.0),
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: (state.activeFiltered)? Colors.grey[300]: null,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Text('ACTIVE (${state.activeCases().length})', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height: 16.0),
                      if (state.createdCaseLoaded && state.joinedCaseLoaded)
                        for (Map c in state.filteredCases())
                          CaseCard(
                            currentUserId: _userId,
                            caseId: c['case_id'],
                            title: c['title'],
                            time: c['submitted_date'],
                            active: state.activeFiltered,
                          ),
                      if (!state.createdCaseLoaded || !state.joinedCaseLoaded)
                        Text('Loading data', style: GoogleFonts.openSans()),
                      SizedBox(height: 16.0),
                      if (!state.activeFiltered && state.filteredCases().length == 0)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('You can tell and submit your situation here', style: GoogleFonts.openSans()),
                            SizedBox(height: 12.0,),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CreateCaseScreen(
                                      currentUserId: _userId,
                                    )
                                  )
                                );
                              },
                              child: Text(
                                'create your case', 
                                style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0,),
                              ),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      if (state.activeFiltered && state.filteredCases().length == 0)
                        Text('No case in progress', style: GoogleFonts.openSans(), textAlign: TextAlign.center,),
                    ],
                  );
                },
              ),
            )
          ),
        ),
      ),
    );
  }
}

class CreateNewCaseButton extends StatelessWidget {
  final String _currentUserId;
  
  CreateNewCaseButton({Key key, @required String currentUserId})
      : _currentUserId = currentUserId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[300],
      shape: CircleBorder(),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateCaseScreen(
                currentUserId: _currentUserId,
              )
            )
          );
        },
        splashColor: Colors.black.withOpacity(0.3),
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Icon(FontAwesomeIcons.plus, size: 22.0,),
        ),
      )
    );
  }
}

class CaseCard extends StatelessWidget {
  final String currentUserId, caseId, title, time;
  final bool active;

  CaseCard({
    @required this.currentUserId,
    @required this.caseId,
    @required this.title,
    @required this.time,
    @required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      color: Color.fromRGBO(230, 230, 230, 1.0),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title', style: GoogleFonts.openSans(fontSize: 19.0, fontWeight: FontWeight.w700),),
            Text('$time', style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w300)),
          ],
        )
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              color: Colors.white,
              shape: CircleBorder(),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CaseInfoScreen(caseId: caseId, currentUserId: currentUserId,)
                    )
                  );
                },
                splashColor: Colors.black.withOpacity(0.3),
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(FontAwesomeIcons.search, size: 19.0,),
                ),
              )
            ),
            SizedBox(width: 8.0,),
            if (this.active)
              Material(
                color: Colors.white,
                shape: CircleBorder(),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MessagingScreen(caseId: caseId, userId: currentUserId,)
                      )
                    );
                  },
                  splashColor: Colors.black.withOpacity(0.3),
                  customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(FontAwesomeIcons.comment, size: 19.0,),
                  ),
                )
              ),
          ],
        ),
      ),
    );
  }
}
