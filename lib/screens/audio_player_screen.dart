import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../blocs/audio_bloc.dart';
import '../blocs/audio_event.dart';
import '../blocs/audio_state.dart';
import '../widgets/wave_visualizer.dart';
import '../widgets/play_pause_button.dart';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/audio_bloc.dart';
import '../blocs/audio_event.dart';
import '../blocs/audio_state.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  static const audioUrl =
      "https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3";

  @override
  Widget build(BuildContext context) {
    // Dispatch LoadAudio event
    context.read<AudioPlayerBloc>().add(LoadAudio(audioUrl));

    return Scaffold(
      body: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          final bloc = context.read<AudioPlayerBloc>();

          return Stack(
            children: [
              // Background Image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Bottom Audio Player UI
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromRGBO(49, 49, 49, 0.75),
                  ),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Instant Crush',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'feat. Julian Casablancas',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Waveform or Loading Indicator
                      if (state is AudioLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (state is AudioLoaded ||
                          state is AudioPlaying ||
                          state is AudioPaused)
                        Column(
                          children: [
                            AudioFileWaveforms(
                              size:
                                  Size(MediaQuery.of(context).size.width, 100),
                              playerController: bloc.playerController,
                              waveformType: WaveformType.long,
                              playerWaveStyle: const PlayerWaveStyle(
                                fixedWaveColor: Colors.grey,
                                liveWaveColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          50.0), // Adjust the radius as needed
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 12.0)),
                                onPressed: () {
                                  bloc.add(state is AudioPlaying
                                      ? PauseAudio()
                                      : PlayAudio());
                                },
                                child: Icon(
                                  state is AudioPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
