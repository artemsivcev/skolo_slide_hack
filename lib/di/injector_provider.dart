import 'package:get_it/get_it.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';

/// It is necessary to register a file in the "injector"
/// by an appropriate method for organizing common access to the file
final GetIt injector = GetIt.I;

Future<void> setupInjection() async {
  injector.registerSingleton(PuzzleState());

  await injector.allReady();
}

/// Returns a registered injection with a type T.
/// If injector not found a such injection then a null returned.
dynamic getInjectionByType<T extends Object>() {
  try {
    return injector<T>();
  } catch (_) {
    // injector can not find a injection with type T

    return null;
  }
}
