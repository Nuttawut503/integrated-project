import 'package:LAWTALK/controllers/bottom-nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:LAWTALK/view/case_lists_screen.dart';
import 'package:LAWTALK/view/relevant_case_screen.dart';
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
        appBar: AppBar(title: Text('LAWTALK'),),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavBloc>(context).add(PageIndexUpdated(pageNumber: index));
            },
            children: <Widget>[
              CaseListsScreen(
                currentUserId: widget._currentUser['id'],
              ),
              RelevantCaseScreen(
                currentUserId: widget._currentUser['id'],
              ),
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
              selectedIndex: state.currentPage,
              onItemSelected: (index) {
                _pageController.jumpToPage(index);
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  title: Text(' Case'),
                  icon: Icon(FontAwesomeIcons.fileArchive),
                ),
                BottomNavyBarItem(
                  title: Text(' Chat'),
                  icon: Icon(FontAwesomeIcons.comments),
                ),
                BottomNavyBarItem(
                  title: Text(' Setting'),
                  icon: Icon(FontAwesomeIcons.cog),
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
