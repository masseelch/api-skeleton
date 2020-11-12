import 'package:client/services/token.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              'Money',
              style: const TextStyle().copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            decoration: BoxDecoration(color: theme.colorScheme.primary),
          ),
          const Divider(),
          const _Logout(),
        ],
      ),
    );
  }
}

class _Logout extends StatelessWidget {
  const _Logout();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        'Abmelden', //AppLocalizations.of(context).logout,
        style: theme.textTheme.bodyText1.copyWith(color: theme.errorColor),
      ),
      leading: Icon(Icons.exit_to_app, color: theme.errorColor),
      onTap: () async {
        if (await TokenService.of(context).deleteToken()) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
        } else {
          // todo - error handling (unlikely to occur though)
        }
      },
    );
  }
}