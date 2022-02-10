import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/presentation/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide puzzle',
      theme: ThemeData(
        primaryColor: const Color(0xFFC19AFC),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MainScreen(),
    );
  }
}
