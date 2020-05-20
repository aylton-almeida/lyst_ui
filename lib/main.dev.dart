import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lystui/routes.dart';

Future main() async {
  await DotEnv().load('envDev.env');
  print('Running dev env backend-url: ${DotEnv().env['BACKEND_URL']}');
  return Routes();
}
