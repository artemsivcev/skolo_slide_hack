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
        Locale('ru', 'RU'),
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
  final binding = WidgetsFlutterBinding.ensureInitialized();

  // Preload all assets to prevent flash when they are loaded.
  binding.deferFirstFrame();
  binding.addPostFrameCallback((_) async {
    BuildContext? context = binding.renderViewElement;
    if (context != null) {
      // Run any sync or awaited async function you want to wait for before showing your UI
      await precacheImage(
          const AssetImage('assets/images/avatar_artem.png'), context);
      await precacheImage(
          const AssetImage('assets/images/avatar_dasha.png'), context);
      await precacheImage(
          const AssetImage('assets/images/avatar_maxim.png'), context);
      await precacheImage(
          const AssetImage('assets/images/avatar_chris.png'), context);
    }
    binding.allowFirstFrame();
  });
  await setupInjection();
  await EasyLocalization.ensureInitialized();
}
