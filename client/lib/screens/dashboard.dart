import 'package:flutter/material.dart';

import '../generated/client/user.dart';
import '../generated/model/account.dart';
import '../services/token.dart';
import '../widgets/drawer.dart';
import '../widgets/progress_indicators.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Account>> _accounts$;

  @override
  void initState() {
    super.initState();

    TokenService.of(context).getUser().then((user) {
      setState(() {
        _accounts$ = UserClient.of(context).accounts(user);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawer = const AppDrawer();
    final appBar = AppBar(title: const Text('Kostenstellen'));

    if (_accounts$ == null) {
      return Scaffold(
        drawer: drawer,
        appBar: appBar,
        body: const Center(child: const CircularProgressIndicator()),
      );
    }

    return Scaffold(
      drawer: drawer,
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // do stuff
        },
      ),
      body: FutureBuilder<List<Account>>(
        future: _accounts$,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Container();
            // todo - handle error
          }

          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final acc = snapshot.data[index];

              return ListTile(
                title: Text(acc.title),
              );
            },
          );
        },
      ),
    );
  }
}
