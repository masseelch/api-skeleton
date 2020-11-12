import 'package:client/screens/login.dart';
import 'package:client/screens/splash.dart';
import 'package:client/services/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'generated/repository/provider.dart';
import 'utils/dio.dart';

class App extends StatefulWidget {
  const App({@required this.config}) : assert(config != null);

  final Config config;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _tokenService = TokenService();
  GlobalObjectKey<NavigatorState> _navigatorKey;
  Dio _dio;

  @override
  void initState() {
    super.initState();

    _navigatorKey = GlobalObjectKey<NavigatorState>(this);

    _initDio();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tokenService.getToken().then((t) {
        _navigatorKey.currentState
            .pushReplacementNamed(t == null ? '/login' : '/home');
      }); // todo - check if token is still valid before redirect to home?
    });
  }

  @override
  void dispose() {
    _dio.close(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset('images/logo.svg', width: 200);

    return MultiProvider(
        providers: [
          GeneratedRepositoryProvider(dio: _dio),
          Provider<TokenService>.value(value: _tokenService),
          Provider<Config>.value(value: widget.config),
        ],
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          routes: {
            '/': (_) => SplashScreen(logo: logo),
            '/login': (_) => LoginScreen(logo: logo),
            '/home': (_) => Text('home'),
          },
        ));
  }

  void _initDio() {
    _dio = newDio(widget.config);

    // Add authentication token.
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) async {
        options.headers['Authorization'] = await _tokenService.getToken();
        return options;
      },
    ));
  }
}
