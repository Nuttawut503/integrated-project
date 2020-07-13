import 'package:LAWTALK/controllers/bottom-nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
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
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          )..add(AppStarted())
        ),
        BlocProvider<BottomNavBloc>(
          create: (context) => BottomNavBloc()
        ),
      ],
      child: MyApp(userRepository: userRepository),
    )
  );
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
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
            }
            return VerifyScreen(
              currentUser: state.currentUser,
            );
          }
          return SplashScreen();
        },
      )
    );
  }
}
