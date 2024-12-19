import 'package:audio_assign/screens/audio_player_screen.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/audio_bloc.dart';


main() {
  runApp(MaterialApp(home: AudioWidgetTest()));
}


class AudioWidgetTest extends StatelessWidget {
  const AudioWidgetTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioPlayerBloc(PlayerController()),
      child: const AudioPlayerScreen(),
    );
  }
}