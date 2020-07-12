import 'package:LAWTALK/controllers/bottom-nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:LAWTALK/view/case_lists_screen.dart';
import 'package:LAWTALK/view/relevant_case_screen.dart';
import 'package:LAWTALK/view/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map _currentUser;

  HomeScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavBloc>(context).add(GetPage(page: index));
            },
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/pekora.jpg"))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.red[500],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          'Peko↗️Peko↘️Peko↗ ${widget._currentUser['name']}',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LoggedOut());
                        },
                        child: Text(
                          'Sign out',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        color: Colors.green,
                      ),
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/shinobu.jpg"),
                        fit: BoxFit.cover)),
              ),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.blue,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: state.page,
          onItemSelected: (index) {
            BlocProvider.of<BottomNavBloc>(context).add(GetPage(page: index));
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(title: Text('Pekora'), icon: Icon(Icons.home)),
            BottomNavyBarItem(title: Text('Best'), icon: Icon(Icons.apps)),
            BottomNavyBarItem(
                title: Text('Hololive'), icon: Icon(Icons.chat_bubble)),
            BottomNavyBarItem(title: Text('Waifu'), icon: Icon(Icons.settings)),
          ],
        ),
      );
    });
  }
}
