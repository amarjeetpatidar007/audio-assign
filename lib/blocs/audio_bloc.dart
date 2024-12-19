import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'audio_event.dart';
import 'audio_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final PlayerController playerController;

  AudioPlayerBloc(this.playerController) : super(AudioPlayerInitial()) {
    on<LoadAudio>(_onLoadAudio);
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
  }

  Future<void> _onLoadAudio(LoadAudio event, Emitter<AudioPlayerState> emit) async {
    emit(AudioLoading());

    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = "${directory.path}/test_audio.mp3";

      final response = await http.get(Uri.parse(event.audioUrl));
      if (response.statusCode == 200) {
        final file = File(path);
        await file.writeAsBytes(response.bodyBytes);

        await playerController.preparePlayer(
          path: path,
          shouldExtractWaveform: true,
        );
        emit(AudioLoaded(path));
      } else {
        emit(AudioError("Failed to download audio: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AudioError("Error loading audio: $e"));
    }
  }

  Future<void> _onPlayAudio(PlayAudio event, Emitter<AudioPlayerState> emit) async {
    try {
      await playerController.startPlayer();
      emit(AudioPlaying());
    } catch (e) {
      emit(AudioError("Error playing audio: $e"));
    }
  }

  Future<void> _onPauseAudio(PauseAudio event, Emitter<AudioPlayerState> emit) async {
    try {
      await playerController.pausePlayer();
      emit(AudioPaused());
    } catch (e) {
      emit(AudioError("Error pausing audio: $e"));
    }
  }
}
