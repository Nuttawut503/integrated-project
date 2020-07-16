import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/case-missing/case_missing_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LAWTALK/view/case_info_screen.dart';
import 'package:badges/badges.dart';

class MissingCasesScreen extends StatelessWidget {
  final Map _currentUser;

  MissingCasesScreen({Key key, @required Map currentUser})
    : _currentUser = currentUser,
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
      child: BlocProvider<MissingCasesBloc>(
        create: (context) => MissingCasesBloc(userId: _currentUser['id'])..add(MissingCasesLoadingStarted()),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: MissingCases(),
        ),
      ),
    );
  }
}

class MissingCases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 16.0),
        BlocBuilder<MissingCasesBloc, MissingCasesState>(
          builder: (context, state) {
            if (state is MissingCasesLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Someone needs your help', style: GoogleFonts.openSans(),),
                  SizedBox(height: 12.0,),
                  for (Map item in state.missingCases)
                    CaseCard(
                      caseId: item['case_id'],
                      title: item['title'],
                      time: item['submitted_date'],
                      tags: item['tags'],
                    )
                ],
              );
            }
            if (state is MissingCasesLoadingStarted) {
              return Text('No cases are reported', style: GoogleFonts.openSans(),);
            }
            return Text('Loading data...', style: GoogleFonts.openSans(),);
          },
        )
      ],
    );
  }
}

class CaseCard extends StatelessWidget {
  final String caseId, title, time;
  final List tags;

  CaseCard({
    @required this.caseId,
    @required this.title,
    @required this.time,
    @required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    Widget _tagList = Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 6.0,
      children: [
        Text('tags: ', style: GoogleFonts.openSans(),),
        for (String tag in tags)
          Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Badge(
              badgeColor: Color.fromRGBO(166, 200, 200, 1.0),
              padding: EdgeInsets.all(5.0),
              shape: BadgeShape.square,
              borderRadius: 20,
              toAnimate: false,
              badgeContent: Text('$tag', style: GoogleFonts.openSans(color: Colors.black)),
            ),
          )
      ],  
    );
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      color: Color.fromRGBO(224, 224, 224, 1.0),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title', style: GoogleFonts.openSans(fontSize: 19.0, fontWeight: FontWeight.w700),),
            Text('$time', style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w300)),
            SizedBox(height: 4.0,),
            if (tags != null)
              _tagList
          ],
        )
        ),
        trailing: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CaseInfoScreen(caseId: caseId)
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
      ),
    );
  }
}
