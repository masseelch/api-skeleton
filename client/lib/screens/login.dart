import 'package:client/services/token.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../dialogs/loading.dart';
import '../services/token.dart';
import '../snackbars/error.dart';
import '../utils/dio.dart';

const _gap = 20.0;
const _padding = 40.0;
const _imageWidth = 200.0;

class LoginScreen extends StatefulWidget {
  LoginScreen({@required this.logo}) : assert(logo != null);

  final Widget logo;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _focusScopeNode = FocusScopeNode();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    if (Config.of(context).isDev) {
      _email = 'user@api.com';
      _password = 'passw0rd!';
    }
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final t = BaseLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 2 * _imageWidth),
            child: Form(
              key: _formKey,
              child: FocusScope(
                node: _focusScopeNode,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 2 * _padding),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _imageWidth),
                      child: widget.logo,
                    ),
                    const SizedBox(height: _padding),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: _padding),
                      child: TextFormField(
                        initialValue: _email,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _focusScopeNode.nextFocus();
                        },
                        decoration: InputDecoration(
                          // labelText: t.loginEmailLabel,
                          // hintText: t.loginEmailLabel,
                          labelText: 'E-Mail',
                          hintText: 'E-Mail',
                        ),
                        validator: (v) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(v)) {
                            return null;
                          }

                          return 'Dies ist keine gültige E-Mail';
                        },
                        onSaved: (v) => _email = v,
                      ),
                    ),
                    const SizedBox(height: _gap),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: _padding),
                      child: TextFormField(
                        initialValue: _password,
                        autocorrect: false,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _focusScopeNode.unfocus();
                          _submit(context);
                        },
                        decoration: InputDecoration(
                          // labelText: t.loginPasswordLabel,
                          // hintText: t.loginPasswordLabel,
                          labelText: 'Passwort',
                          hintText: 'Passwort',
                        ),
                        validator: (v) {
                          if (v == null || v.length < 8) {
                            return 'Das Passwort muss mindestens 8 Zeichen lang sein.';
                          }

                          return null;
                        },
                        onSaved: (v) => _password = v,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _padding,
                        vertical: _gap,
                      ),
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text('ANMELDEN'),
                        // child: Text(t.loginSubmitLabel.toUpperCase()),
                        onPressed: () {
                          _submit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      showLoadingDialog(context);

      final dio = newDio(Config.of(context));

      try {
        final r = await dio.post('/auth/token', data: {
          'email': _email,
          'password': _password,
        });

        if (await TokenService.of(context).setToken(r.data['token'])) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
        } else {
          showErrorSnackBar(context, scaffold: _scaffoldKey.currentState);
          hideLoadingDialog(context);
        }
      } catch (e) {
        print(e);
        showErrorSnackBar(
          context,
          scaffold: _scaffoldKey.currentState,
          content: 'Falsche Zugangsdaten',
          // content: BaseLocalizations.of(context).loginWrongCredentials,
        );
        hideLoadingDialog(context);
      } finally {
        dio.close();
      }
    }
  }
}
