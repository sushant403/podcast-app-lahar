// import 'dart:async';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_media_notification/flutter_media_notification.dart';
// import 'package:songapp/Api/Networkutils.dart';
// import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
// import 'package:songapp/screens/music/musicScreen.dart';

// class BottomsheetScreen extends StatefulWidget {
//   int mode;
//   List<MostPlayedItem> songs;
//   int index;

//   BottomsheetScreen(this.songs, this.index, this.mode);
//   @override
//   _BottomsheetScreenState createState() => _BottomsheetScreenState();
// }

// class _BottomsheetScreenState extends State<BottomsheetScreen> {
//   MostPlayedItem mostPlayedItem;
//   String musicUrl = '';

//   String musicurl2 =
//       'https://www.evenmore.co.in/manah_wellness/uploads/music/Instrument_Music_1_20200723162814.mp3';
//   bool playing = false;
//   IconData playBtn = Icons.play_arrow;
//   AudioPlayer audioPlayer = new AudioPlayer();
//   bool isplaying = false;
//   String currentSong = '';
//   PlayerMode mode;
//   AudioPlayer _audioPlayer;
//   AudioPlayerState _audioPlayerState;
//   Duration _duration;
//   Duration _position;
//   bool isLocal;

//   AudioPlayerState _playerState = AudioPlayerState.STOPPED;
//   StreamSubscription _durationSubscription;
//   StreamSubscription _positionSubscription;
//   StreamSubscription _playerCompleteSubscription;
//   StreamSubscription _playerErrorSubscription;
//   StreamSubscription _playerStateSubscription;
//   bool isplay = false;
//   get _isPlaying => _playerState == AudioPlayerState.PLAYING;
//   get _isPaused => _playerState == AudioPlayerState.PAUSED;

//   // PageManager _pageManager;
//   @override
//   void initState() {
//     super.initState();
//     mostPlayedItem = widget.songs[widget.index];
//     musicUrl = Networkutils.Baserl1 + mostPlayedItem.musicfile;
//     print(musicUrl);
//     // _pageManager = PageManager();
//     // url = musicUrl;
//     // _audioPlayer.play(musicUrl);

//     this.mode = PlayerMode.MEDIA_PLAYER;
//     this.isLocal = false;
//     _initAudioPlayer();
//     show('fda', 'adafs');
//   }

//   // @override
//   // void dispose() {
//   //   _pageManager.dispose();
//   //   super.dispose();
//   // }
//   void _initAudioPlayer() {
//     _audioPlayer = AudioPlayer();

//     _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
//       setState(() => _duration = duration);
//     });

//     _positionSubscription =
//         _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
//               _position = p;
//             }));

//     _playerCompleteSubscription =
//         _audioPlayer.onPlayerCompletion.listen((event) {
//       _onComplete();
//       setState(() {
//         _position = _duration;
//       });
//     });

//     _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
//       print('audioPlayer error : $msg');
//       setState(() {
//         _playerState = AudioPlayerState.STOPPED;
//         _duration = Duration(seconds: 0);
//         _position = Duration(seconds: 0);
//       });
//     });

//     _audioPlayer.onPlayerStateChanged.listen((state) {
//       if (!mounted) return;
//       setState(() {
//         _audioPlayerState = state;
//       });
//     });

//     _play();
//   }

//   @override
//   void dispose() async {
//     _audioPlayer.dispose();
//     // _durationSubscription.dispose();
//     // _positionSubscription.cancel();
//     // _playerCompleteSubscription.cancel();
//     // _playerErrorSubscription.cancel();
//     // _playerStateSubscription.cancel();
//     super.dispose();
//     await MediaNotification.hideNotification();
//   }

//   String status = 'hidden';

//   Future<void> hide() async {
//     try {
//       await MediaNotification.hideNotification();
//       setState(() => status = 'hidden');
//       // await MediaNotification.setListener(event, callback)
//     } on PlatformException {}
//   }

//   Future<void> show(title, author) async {
//     try {
//       await MediaNotification.showNotification(title: title, author: author);
//       setState(() => status = 'play');
//     } on PlatformException {}
//   }

//   Future<int> _pause() async {
//     final result = await _audioPlayer.pause();
//     if (result == 1)
//       setState(() {
//         _playerState = AudioPlayerState.PAUSED;

//         isplay = false;
//       });

//     return result;
//   }

//   GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

//   Future<int> _play() async {
//     final playPosition = (_position != null &&
//             _duration != null &&
//             _position.inMilliseconds > 0 &&
//             _position.inMilliseconds < _duration.inMilliseconds)
//         ? _position
//         : null;
//     final result = await _audioPlayer.play(musicUrl,
//         isLocal: isLocal, position: playPosition);
//     if (result == 1) setState(() => _playerState = AudioPlayerState.PLAYING);
//     isplay = true;

//     return result;
//   }

//   void _onComplete() {
//     setState(() => _playerState = AudioPlayerState.STOPPED);

//     // if (widget.index < widget.songs.length)
//     //   Navigator.of(context).pushReplacement(
//     //     new MaterialPageRoute(
//     //       builder: (context) => Musicscreens(
//     //         widget.songs,
//     //         widget.index + 1,
//     //         1,
//     //       ),
//     //     ),
//     //   );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldState,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(),
//       body: Center(
//         child: Row(
//           children: <Widget>[
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.skip_previous,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 isplay == true ? _pause() : _play();
//                 if (!playing) {
//                   // playmusic(musicUrl);
//                   setState(() {
//                     playBtn = Icons.pause;
//                     playing = true;
//                   });
//                 } else {
//                   _audioPlayer.pause();
//                   setState(() {
//                     playBtn = Icons.play_arrow;
//                     playing = false;
//                   });
//                 }
//               },
//               icon: Icon(
//                 isplay == true ? Icons.pause : Icons.play_arrow,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 setState(() => _playerState = AudioPlayerState.STOPPED);
//                 if (widget.index + 1 < widget.songs.length)
//                   Navigator.of(context).pushReplacement(
//                     new MaterialPageRoute(
//                       builder: (context) => Musicscreens(
//                         widget.songs,
//                         widget.index + 1,
//                         1,
//                       ),
//                     ),
//                   );
//               },
//               icon: Icon(
//                 Icons.skip_previous,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
