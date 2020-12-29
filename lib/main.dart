import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:tinji/tinji.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load configuration
  if (kReleaseMode) {
    await GlobalConfiguration().loadFromAsset("production");
  } else {
    await GlobalConfiguration().loadFromAsset("develop");
  }
  runApp(Tinji());
}
