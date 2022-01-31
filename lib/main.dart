import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/worker_web.dart';
import 'package:skolo_slide_hack/presentation/application.dart';

Future<void> main() async {
  CustomWorker();

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

const String workerName = 'name_1';

class CustomWorker {
  late BackgroundWorkerWeb workerWeb;

  void doSomething(Map<String, dynamic> message) {
    workerWeb.listen(
      (args) {
        print("ARGS: $args");
      },
      context: message,
      cancelOnError: false,
      onDone: () {},
      onError: () {},
    );
  }

  void onInitialized() {
    workerWeb.sendTo(workerName, {
      // tell the worker to start its job
      'message': 'Hello from the Flutter!',
    });
  }

  CustomWorker() {
    workerWeb = BackgroundWorkerWeb();

    workerWeb.spawn(doSomething, name: workerName, onInitialized: onInitialized,
        onFromWorker: (x) {
      print("from onFromWorker: $x");
    });
  }
}
