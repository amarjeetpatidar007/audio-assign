abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioLoading extends AudioPlayerState {}

class AudioLoaded extends AudioPlayerState {
  final String path;

  AudioLoaded(this.path);
}

class AudioPlaying extends AudioPlayerState {}

class AudioPaused extends AudioPlayerState {}

class AudioError extends AudioPlayerState {
  final String message;

  AudioError(this.message);
}
