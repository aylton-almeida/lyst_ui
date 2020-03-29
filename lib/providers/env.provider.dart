import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvProvider extends ChangeNotifier {
  String backendUrl;

  EnvProvider({bool isDev}) {
    this.backendUrl = DotEnv().env[isDev ? 'BACKEND_DEV_URL' : 'BACKEND_URL'];
  }
}
