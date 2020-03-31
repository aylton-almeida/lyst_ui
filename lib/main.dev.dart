import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lystui/routes.dart';

Future main() async {
  await DotEnv().load('.envDev');
  return Routes(isDev: true);
}
