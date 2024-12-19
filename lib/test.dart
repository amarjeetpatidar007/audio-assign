// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
//
// class AudioWidgetTest extends StatefulWidget {
//   const AudioWidgetTest({Key? key}) : super(key: key);
//
//   @override
//   State<AudioWidgetTest> createState() => _AudioWidgetTestState();
// }
//
// class _AudioWidgetTestState extends State<AudioWidgetTest> {
//   late final PlayerController playerController;
//   String? path;
//   late Directory directory;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeController();
//     _prepareAudio();
//   }
//
//   void _initializeController() {
//     playerController = PlayerController();
//   }
//
//   Future<void> _prepareAudio() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//
//       // Get the directory to save the audio file
//       directory = await getApplicationDocumentsDirectory();
//       path = "${directory.path}/test_audio.mp3";
//
//       // URL of the audio file
//       const audioUrl = "https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3";
//
//       // Download the audio file
//       await _downloadAudio(audioUrl, path!);
//
//       // Prepare the player with the downloaded file
//       await playerController.preparePlayer(path: path!,shouldExtractWaveform: true);
//     } catch (e) {
//       debugPrint("Error preparing audio: $e");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _downloadAudio(String url, String savePath) async {
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final file = File(savePath);
//       await file.writeAsBytes(response.bodyBytes);
//     } else {
//       throw Exception("Failed to download audio: ${response.statusCode}");
//     }
//   }
//
//   @override
//   void dispose() {
//     playerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/img.jpeg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               height: 400,
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width,
//               color: Colors.black.withOpacity(0.8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           'Instant Crush',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 28,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           'feat. Julian Casablancas',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (path != null)
//                           AudioFileWaveforms(
//                             size: Size(MediaQuery.sizeOf(context).width, 100),
//                             playerController: playerController,
//                             waveformType: WaveformType.long,
//                             playerWaveStyle: const PlayerWaveStyle(
//                               scaleFactor: 100,
//                               scrollScale: 1.2,
//                               fixedWaveColor: Colors.grey,
//                               liveWaveColor: Colors.black,
//                               waveCap: StrokeCap.round,
//                             ),
//                           ),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () async {
//                             if (playerController.playerState.isPlaying) {
//                               await playerController.pausePlayer();
//                             } else {
//                               await playerController.startPlayer();
//                             }
//                           },
//                           child: Icon(
//                             playerController.playerState.isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }}
//
