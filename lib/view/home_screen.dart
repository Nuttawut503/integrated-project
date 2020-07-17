import 'package:LAWTALK/controllers/bottom-nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:LAWTALK/view/case_dashboard_screen.dart';
import 'package:LAWTALK/view/missing_cases_screen.dart';
import 'package:LAWTALK/view/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map _currentUser;

  HomeScreen({Key key, @required Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('LAWTALK', style: GoogleFonts.openSans(),),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.folderPlus),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CaseDashboardScreen(
                      userId: widget._currentUser['id'],
                    )
                  )
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavBloc>(context).add(PageIndexUpdated(pageNumber: index));
            },
            children: <Widget>[
              GreetingScreen(isLawyer: widget._currentUser['is_lawyer'],),
              if (widget._currentUser['is_lawyer'])
                MissingCasesScreen(currentUser: widget._currentUser),
              SettingScreen(
                currentUser: widget._currentUser,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
          buildWhen: (previousState, currentState) => previousState.currentPage != currentState.currentPage,
          builder: (context, state) {
            return BottomNavyBar(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              selectedIndex: state.currentPage,
              onItemSelected: (index) {
                _pageController.jumpToPage(index);
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  title: Text('Home', textAlign: TextAlign.center,),
                  icon: Icon(FontAwesomeIcons.home),
                ),
                if (widget._currentUser['is_lawyer'])
                  BottomNavyBarItem(
                    title: Text('Emergency', textAlign: TextAlign.center,),
                    icon: Icon(FontAwesomeIcons.folderOpen),
                  ),
                BottomNavyBarItem(
                  title: Text('Setting', textAlign: TextAlign.center,),
                  icon: Icon(FontAwesomeIcons.userCog),
                ),
              ],
            );
          } 
        ),
      ),
      onWillPop: () async {
        return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?', style: GoogleFonts.openSans()),
            content: Text('Do you want to exit the app',
                style: GoogleFonts.openSans()),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: GoogleFonts.openSans()),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes', style: GoogleFonts.openSans()),
              ),
            ],
          ),
        )) ?? false;
      },
    );
  }
}

class GreetingScreen extends StatelessWidget {
  final bool isLawyer;

  GreetingScreen({Key key, @required this.isLawyer})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Welcome !!', style: GoogleFonts.openSans(fontSize: 39.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 12.0,),
            Text('We really appreciate your cooperation', style: GoogleFonts.openSans(fontWeight: FontWeight.bold),),
            SizedBox(height: 24.0,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(text: 'Tap the my case button (', style: GoogleFonts.openSans(color: Colors.black)),
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(FontAwesomeIcons.folderPlus),
                    ),
                  ),
                  TextSpan(text: ')\nat the top-right of your screen to report your problem', style: GoogleFonts.openSans(color: Colors.black)),
                ]
              ),
            ),
            SizedBox(height: 16.0,),
            if (!isLawyer)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: 'For lawyers, please to swipe to the right side\n or tap the emergency button (', style: GoogleFonts.openSans(color: Colors.black)),
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(FontAwesomeIcons.folderOpen),
                      ),
                    ),
                    TextSpan(text: ') to start investigation', style: GoogleFonts.openSans(color: Colors.black)),
                  ]
                ),
              ),
          ],
        ),
      )
    );
  }
}
