import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'dialogs/feedback.dart';
import 'generated/client/provider.dart';
import 'screens/dashboard.dart';
import 'screens/login.dart';
import 'screens/splash.dart';
import 'screens/tags.dart';
import 'services/token.dart';
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

  // Pre-cache logo.
  final _logo = SvgPicture.asset('images/logo.svg', width: 200);

  @override
  void initState() {
    super.initState();

    _navigatorKey = GlobalObjectKey<NavigatorState>(this);

    _dio = newDio(widget.config);
    _addAuthorizationInterceptor();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tokenService.getToken().then((t) {
        if (t != null) {
          _dio.get('/auth/check').then((_) {
            _addErrorsInterceptor();
            _navigatorKey.currentState.pushReplacementNamed('/dashboard');
          }).catchError((e) {
            if (e is DioError) {
              if (e.response?.statusCode == 401) {
                // todo - remove token
                _navigatorKey.currentState.pushReplacementNamed('/login');
              } else {
                // todo - handle this case
              }
            } else {
              // todo - handle this case
            }
          });
        } else {
          _navigatorKey.currentState.pushReplacementNamed('/login');
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(_logo.pictureProvider, context);
  }

  @override
  void dispose() {
    _dio.close(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ClientProvider(dio: _dio),
          Provider<TokenService>.value(value: _tokenService),
          Provider<Config>.value(value: widget.config),
        ],
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Title',
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.pinkAccent,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routes: {
            '/': (_) => SplashScreen(logo: _logo),
            '/login': (_) => LoginScreen(logo: _logo),
            '/dashboard': (_) => const DashboardScreen(),
            '/tags': (_) => const TagsScreen(),
          },
        ));
  }

  void _addAuthorizationInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) async {
        options.headers['Authorization'] = await _tokenService.getToken();
        return options;
      },
    ));
  }

  // Handle some errors early.
  void _addErrorsInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (e) async {
        switch (e.type) {
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
            // TODO: Handle this case. Introduce some kind of feedback to the user whether the server is reachable or not.
            break;

          case DioErrorType.RESPONSE:
            // TODO: Handle this case.
            switch (e.response.statusCode) {
              case 401:
                // Session has expired or account was disabled.
                await showFeedbackDialog(
                  _navigatorKey.currentState.overlay.context,
                  title: 'Sitzung abgelaufen', //t.apiError401Title,
                  content:
                      'Die aktuelle Sitzung is abgelaufen. Bitte logge dich erneut ein.', // t.apiError401Content,
                );

                if (await _tokenService.logout()) {
                  _navigatorKey.currentState.pushNamedAndRemoveUntil(
                    '/login',
                    (_) => false,
                  );
                }

                // This should not happen.
                return e;

              case 500:
                return e; // todo - handle this
            }
            break;

          case DioErrorType.CANCEL:
          case DioErrorType.DEFAULT:
            // TODO: Handle this case.
            return e;
        }
      },
    ));
  }
}
