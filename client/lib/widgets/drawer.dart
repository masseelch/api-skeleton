import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/token.dart';

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
          const DashboardDrawerTile(),
          const TagsDrawerTile(),
          const Divider(),
          const _LogoutDrawerTile(),
        ],
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  const _DrawerListTile({
    @required this.iconData,
    @required this.title,
    @required this.url,
  })  : assert(iconData != null),
        assert(title != null),
        assert(url != null);

  final IconData iconData;
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: Theme.of(context).primaryColor),
      title: Text(title),
      onTap: () => _navigateNamed(context, url),
    );
  }
}

class DashboardDrawerTile extends StatelessWidget {
  const DashboardDrawerTile();

  @override
  Widget build(BuildContext context) {
    return _DrawerListTile(
      iconData: Icons.apps,
      title: AppLocalizations.of(context).screenDashboardTitle,
      url: '/dashboard',
    );
  }
}

class TagsDrawerTile extends StatelessWidget {
  const TagsDrawerTile();

  @override
  Widget build(BuildContext context) {
    return _DrawerListTile(
      iconData: Icons.label,
      title: AppLocalizations.of(context).screenTagsTitle,
      url: '/tags',
    );
  }
}

void _navigateNamed(BuildContext context, String name) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    name,
    (_) => false,
  );
}

class _LogoutDrawerTile extends StatelessWidget {
  const _LogoutDrawerTile();

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
        if (await TokenService.of(context).logout()) {
          _navigateNamed(context, '/login');
        } else {
          // todo - error handling (unlikely to occur though)
        }
      },
    );
  }
}
