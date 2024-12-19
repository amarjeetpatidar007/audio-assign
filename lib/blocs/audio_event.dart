abstract class AudioPlayerEvent {}

class LoadAudio extends AudioPlayerEvent {
  final String audioUrl;

  LoadAudio(this.audioUrl);
}

class PlayAudio extends AudioPlayerEvent {}

class PauseAudio extends AudioPlayerEvent {}
