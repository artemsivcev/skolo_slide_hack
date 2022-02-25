import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/screens/main_screen.dart';
import 'package:skolo_slide_hack/presentation/screens/entry_screen.dart';
import 'package:skolo_slide_hack/presentation/widgets/entry/team_introduction.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide puzzle',
      theme: ThemeData(
        primaryColor: colorsBackgroundMenu,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Stack(
        children: const [
          MainScreen(),
          EntryScreen(
            child: TeamIntroduction(),
          ),
        ],
      ),
    );
  }
}
