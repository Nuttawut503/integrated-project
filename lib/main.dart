import 'package:LAWTALK/controllers/bottom-nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LAWTALK/bloc_debugger.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/api/user_repository.dart';
import 'package:LAWTALK/view/home_screen.dart';
import 'package:LAWTALK/view/verify_screen.dart';
import 'package:LAWTALK/view/login_screen.dart';
import 'package:LAWTALK/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
                userRepository: userRepository,
              )..add(AppStarted())),
      BlocProvider<BottomNavBloc>(create: (context) => BottomNavBloc())
    ],
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAWTALK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WillPopScope(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              return LoginScreen(
                userRepository: _userRepository,
              );
            }
            if (state is Authenticated) {
              if (state.currentUser['verified']) {
                return HomeScreen(
                  currentUser: state.currentUser,
                );
              } else {
                return VerifyScreen(
                  currentUser: state.currentUser,
                );
              }
            }
            return SplashScreen();
          },
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
      ),
    );
  }
}
