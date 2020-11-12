import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum Environment { dev, production }

class Config {
  const Config({
    @required this.env,
    @required this.baseUrl,
    this.bannerMessage,
  })
      : assert(env != null),
        assert(baseUrl != null);

  final Environment env;
  final String baseUrl;
  final String bannerMessage;

  bool get isDev => env == Environment.dev;

  bool get isProduction => env == Environment.production;

  static Config of(BuildContext context) =>
      Provider.of<Config>(context, listen: false);
}
