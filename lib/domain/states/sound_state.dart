import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';

part 'sound_state.g.dart';

class SoundState = _SoundState with _$SoundState;

/// State is used for controlling sounds of the game
abstract class _SoundState with Store {
  /// Common state to play or mute music
  @observable
  bool isSoundPlay = false;

  /// main audio controller class for surrounding
  final mainPlayer = AudioPlayer();

  /// secondary audio controller class for effect
  final effectsPlayer = AudioPlayer();

  /// Action to change sound state
  @action
  void toggleSoundBtn() {
    isSoundPlay = !isSoundPlay;

    toggleMainSound();
  }

  /// fun check audioSource in [mainPlayer]
  /// and if it null sets main.mp3 and loops it
  @action
  void preloadMainAudio() {
    if (mainPlayer.audioSource == null) {
      mainPlayer.setAsset('assets/audio/main.mp3');
      mainPlayer.setLoopMode(LoopMode.all);
    }
  }

  /// fun pause and play sound in [mainPlayer]
  @action
  Future<void> toggleMainSound() async {
    if (mainPlayer.playing) {
      mainPlayer.pause();
      effectsPlayer.pause();
    } else {
      preloadMainAudio();
      mainPlayer.play();
    }
  }

  /// fun set forward.mp3 in [effectsPlayer] and playing it once
  @action
  void playForwardSound() {
    effectsPlayer.setAsset('assets/audio/forward.mp3');
    effectsPlayer.setLoopMode(LoopMode.off);
    play(effectsPlayer);
  }

  /// fun set backward.mp3 in [effectsPlayer] and playing it once
  @action
  void playBackwardSound() {
    effectsPlayer.setAsset('assets/audio/backward.mp3');
    effectsPlayer.setLoopMode(LoopMode.off);
    play(effectsPlayer);
  }

  /// fun set move.mp3 in [effectsPlayer] and playing it once
  @action
  void playMoveSound() {
    effectsPlayer.setAsset('assets/audio/move.mp3');
    effectsPlayer.setLoopMode(LoopMode.off);
    play(effectsPlayer);
  }

  /// fun set not_movable.mp3 in [effectsPlayer] and playing it once
  @action
  void playCantMoveSound() {
    effectsPlayer.setAsset('assets/audio/move.mp3');
    effectsPlayer.setLoopMode(LoopMode.off);
    play(effectsPlayer);
  }

  /// fun set shuffle.mp3 in [effectsPlayer] and playing it once
  @action
  void playShuffleSound() {
    effectsPlayer.setAsset('assets/audio/shuffle.mp3');
    effectsPlayer.setLoopMode(LoopMode.off);
    play(effectsPlayer);
  }

  /// fun set win.mp3 in [effectsPlayer] and playing it once
  @action
  void playWinSound() {
    effectsPlayer.setAsset('assets/audio/win.mp3');
    effectsPlayer.setLoopMode(LoopMode.off);
    play(effectsPlayer);
  }

  /// fun for check sound state and play some effect
  play(AudioPlayer player) {
    if (isSoundPlay) {
      player.play();
    }
  }

  dispose() {
    mainPlayer.dispose();
    effectsPlayer.dispose();
  }
}
