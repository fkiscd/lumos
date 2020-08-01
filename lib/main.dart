import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumos/authentication_bloc/authentication_bloc.dart';
import 'package:lumos/firebase/user_repository.dart';
import 'package:lumos/simple_bloc_observer.dart';
import 'package:lumos/splash_page.dart';
import 'package:lumos/home_page.dart';
import 'login/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
      AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: LumosApp(userRepository: userRepository),
    ),
  );
}

class LumosApp extends StatelessWidget {
  final UserRepository _userRepository;

  LumosApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashPage();
          } else if (state is AuthenticationSuccess) {
            return HomePage(name: state.displayName);
          }
          return LoginPage(userRepository: _userRepository);
        },
      ),
      theme: ThemeData(
          primarySwatch: Colors.amber,
          textSelectionColor: Colors.blue,
          textSelectionHandleColor: Colors.blue,
          accentColor: Colors.yellow
      ),
    );
  }
}
