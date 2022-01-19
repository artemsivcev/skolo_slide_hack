import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/presentation/application.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  await init();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      saveLocale: true,
      useOnlyLangCode: true,
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  await EasyLocalization.ensureInitialized();
}
