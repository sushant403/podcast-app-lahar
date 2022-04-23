// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

// class PageManager {
//   final progressNotifier = ValueNotifier<ProgressBarState>(
//     ProgressBarState(
//       current: Duration.zero,
//       buffered: Duration.zero,
//       total: Duration.zero,
//     ),
//   );
//   final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

//   AudioPlayer _audioPlayer;

//   PageManager() {
//     _init();
//     print('MUsics is' + url);
//   }

//   void _init() async {
//     // initialize the song
//     _audioPlayer = AudioPlayer();
//     await _audioPlayer.setUrl(url);

//     // listen for changes in player state
//     _audioPlayer.playerStateStream.listen((playerState) {
//       final isPlaying = playerState.playing;
//       final processingState = playerState.processingState;
//       if (processingState == ProcessingState.loading ||
//           processingState == ProcessingState.buffering) {
//         buttonNotifier.value = ButtonState.loading;
//       } else if (!isPlaying) {
//         buttonNotifier.value = ButtonState.paused;
//       } else if (processingState != ProcessingState.completed) {
//         buttonNotifier.value = ButtonState.playing;
//       } else {
//         _audioPlayer.seek(Duration.zero);
//         _audioPlayer.pause();
//       }
//     });

//     // listen for changes in play position
//     _audioPlayer.positionStream.listen((position) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: position,
//         buffered: oldState.buffered,
//         total: oldState.total,
//       );
//     });

//     // listen for changes in the buffered position
//     _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: oldState.current,
//         buffered: bufferedPosition,
//         total: oldState.total,
//       );
//     });

//     // listen for changes in the total audio duration
//     _audioPlayer.durationStream.listen((totalDuration) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: oldState.current,
//         buffered: oldState.buffered,
//         total: totalDuration ?? Duration.zero,
//       );
//     });
//   }

//   void play() async {
//     _audioPlayer.play();
//   }

//   void pause() {
//     _audioPlayer.pause();
//   }

//   void seek(Duration position) {
//     _audioPlayer.seek(position);
//   }

//   void dispose() {
//     _audioPlayer.dispose();
//     print('object');
//   }
// }

// class ProgressBarState {
//   ProgressBarState({
//     this.current,
//     this.buffered,
//     this.total,
//   });
//   final Duration current;
//   final Duration buffered;
//   final Duration total;
// }

// enum ButtonState { paused, playing, loading }
// String url = '';
