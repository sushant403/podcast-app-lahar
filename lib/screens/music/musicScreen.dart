// import 'dart:async';
// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_media_notification/flutter_media_notification.dart';
// import 'package:songapp/Api/Networkutils.dart';
// import 'package:songapp/appconfi.dart';
// import 'package:songapp/model/HomeScreen/components/mostplayed.dart';

// import '../../staticData.dart';

// enum PlayerState { stopped, playing, paused }

// // ignore: must_be_immutable
// class Musicscreens extends StatefulWidget {
//   int mode;
//   List<MostPlayedItem> songs;
//   int index;

//   Musicscreens(this.songs, this.index, this.mode);
//   @override
//   _MusicscreensState createState() => _MusicscreensState();
// }

// class _MusicscreensState extends State<Musicscreens>
//     with SingleTickerProviderStateMixin {
//   MostPlayedItem mostPlayedItem;
//   String musicUrl = '';

//   String musicurl2 =
//       'https://www.evenmore.co.in/manah_wellness/uploads/music/Instrument_Music_1_20200723162814.mp3';
//   bool playing = true;

//   bool isplaying = false;
//   PlayerMode mode;
//   AudioPlayer _audioPlayer;
//   AudioPlayerState _audioPlayerState;
//   Duration totalDuration;
//   Duration _position;

//   AudioPlayerState _playerState = AudioPlayerState.STOPPED;
//   // StreamSubscription totalDurationSubscription;
//   // StreamSubscription _positionSubscription;
//   // StreamSubscription _playerCompleteSubscription;
//   // StreamSubscription _playerErrorSubscription;
//   // StreamSubscription _playerStateSubscription;
//   bool isplay = false;
//   // get _isPlaying => _playerState == AudioPlayerState.PLAYING;
//   // get _isPaused => _playerState == AudioPlayerState.PAUSED;
//   get totalDurationText => totalDuration?.toString()?.split('.')?.first ?? '';

//   get _positionText => _position?.toString()?.split('.')?.first ?? '';

//   // PageManager _pageManager;
//   @override
//   void initState() {
//     super.initState();
//     mostPlayedItem = widget.songs[widget.index];
//     musicUrl = Networkutils.Baserl1 + mostPlayedItem.musicfile;
//     print(musicUrl);
//     // _pageManager = PageManager();
//     // url = musicUrl;
//     // AudioPlayer().play();

//     this.mode = PlayerMode.MEDIA_PLAYER;
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 2))
//           ..repeat();
//     _initAudioPlayer();
//     totalDuration = Duration();
//     _position = Duration();
//     // _audioPlayer = AudioPlayer();
//     // AudioPlayer.logEnabled = true;
//     show(mostPlayedItem.musictitle, mostPlayedItem.artistlist[0].artistname);
//   }

//   // @override
//   // void dispose() {
//   //   _pageManager.dispose();
//   //   super.dispose();
//   // }
//   void _initAudioPlayer() {
//     _audioPlayer = AudioPlayer();

//     _audioPlayer.onDurationChanged
//         .listen((duration) => setState(() => duration = totalDuration));
//     // seek(Duration.zero);
//     _audioPlayer.onAudioPositionChanged.listen((p) {
//       setState(() {
//         _position = p;
//         // print(_position);
//       });
//     });

//     _audioPlayer.onPlayerCompletion.listen((event) {
//       _onComplete();
//       // setState(() {
//       _position = totalDuration;
//       // });
//     });

//     // _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
//     //   print('audioPlayer error : $msg');
//     //   setState(() {
//     //     _playerState = PlayerState.stopped as AudioPlayerState;
//     //     totalDuration = Duration(seconds: 0);
//     //     _position = Duration(seconds: 0);
//     //   });
//     // });

//     // _audioPlayer.onPlayerStateChanged.listen((state) {
//     //   if (!mounted) return;
//     //   setState(() {
//     //     _audioPlayerState = state;
//     //   });
//     // });
//     play();
//   }

//   @override
//   void dispose() async {
//     _audioPlayer.dispose();
//     _controller.dispose();
//     super.dispose();
//     await MediaNotification.hideNotification();
//   }

//   String status = 'hidden';

//   Future<void> hide() async {
//     try {
//       await MediaNotification.hideNotification();
//       setState(() => status = 'hidden');
//     } on PlatformException {}
//   }

//   Future<void> show(title, author) async {
//     try {
//       await MediaNotification.showNotification(title: title, author: author);
//       setState(() => status = 'play');
//       MediaNotification.setListener('pause', () {
//         setState(() async {
//           await _audioPlayer.pause();
//           playing = false;
//         });
//       });
//       MediaNotification.setListener('next', () {
//         setState(() {
//           if (widget.index + 1 < widget.songs.length) {
//             show(mostPlayedItem.musictitle,
//                 mostPlayedItem.artistlist[0].artistname);
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => Musicscreens(
//                   widget.songs,
//                   widget.index + 1,
//                   1,
//                 ),
//               ),
//             );
//           } else {
//             show(mostPlayedItem.musictitle,
//                 mostPlayedItem.artistlist[0].artistname);
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => Musicscreens(
//                   widget.songs,
//                   widget.index - widget.songs.length + 1,
//                   1,
//                 ),
//               ),
//             );
//           }
//         });
//       });
//       MediaNotification.setListener('prev', () {
//         setState(() {
//           if (widget.index + 1 < widget.songs.length)
//             show(mostPlayedItem.musictitle,
//                 mostPlayedItem.artistlist[0].artistname);
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (context) => Musicscreens(
//                 widget.songs,
//                 widget.index - 1,
//                 1,
//               ),
//             ),
//           );
//         });
//       });
//       await MediaNotification.setListener('play', () async {
//         setState(() async {
//           await play();
//           print('objects1');
//           playing = true;
//         });
//       });
//     } on PlatformException {}
//   }

//   GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

//   // Future<int> _play() async {
//   //   final playPosition = (_position != null &&
//   //           totalDuration != null &&
//   //           _position.inMilliseconds > 0 &&
//   //           _position.inMilliseconds < totalDuration.inMilliseconds)
//   //       ? _position
//   //       : null;
//   //   final result = await _audioPlayer.play(musicUrl,
//   //       isLocal: isLocal, position: playPosition);
//   //   if (result == 1)
//   //     setState(() {
//   //       _playerState = AudioPlayerState.PLAYING;
//   //       isplay = true;
//   //     });

//   //   return result;
//   // }

//   void _onComplete() {
//     setState(() => _playerState = AudioPlayerState.STOPPED);

//     if (widget.index + 1 < widget.songs.length)
//       Navigator.of(context).pushReplacement(
//         new MaterialPageRoute(
//           builder: (context) => Musicscreens(
//             widget.songs,
//             widget.index + 1,
//             1,
//           ),
//         ),
//       );
//   }

//   play() async {
//     // final playPosition = (_position != null &&
//     //         totalDuration != null &&
//     //         _position.inMilliseconds > 0 &&
//     //         _position.inMilliseconds < totalDuration.inMilliseconds)
//     //     ? _position
//     //     : null;
//     int result = await _audioPlayer.play(
//       musicUrl,
//       // position: playPosition,
//       stayAwake: true,
//     );
//     if (result == 1) {
//       // success
//       show(mostPlayedItem.musictitle, mostPlayedItem.artistlist[0].artistname);
//     }
//   }

//   // ignore: unused_element
//   _pause() async {
//     int result = await _audioPlayer.pause();
//     if (result == 1) {
//       // success
//       show(mostPlayedItem.musictitle, mostPlayedItem.artistlist[0].artistname);
//     }
//   }

//   seekAudio(Duration durationToSeek) {
//     _audioPlayer.seek(durationToSeek);
//   }

//   double data = 0;
//   AnimationController _controller;

//   AppConfig _appConfig;
//   @override
//   Widget build(BuildContext context) {
//     _appConfig = AppConfig(context);
//     return
//         // Scaffold(
//         //   appBar: AppBar(),
//         // );
//         //     MaterialApp(
//         //   home: Scaffold(
//         //     body: Padding(
//         //       padding: const EdgeInsets.all(20.0),
//         //       child: Column(
//         //         children: [
//         //           Spacer(),
//         //           ValueListenableBuilder<ProgressBarState>(
//         //             valueListenable: _pageManager.progressNotifier,
//         //             builder: (_, value, __) {
//         //               return ProgressBar(
//         //                 progress: value.current,
//         //                 buffered: value.buffered,
//         //                 total: value.total,
//         //                 onSeek: _pageManager.seek,
//         //               );
//         //             },
//         //           ),
//         //           ValueListenableBuilder<ButtonState>(
//         //             valueListenable: _pageManager.buttonNotifier,
//         //             builder: (_, value, __) {
//         //               switch (value) {
//         //                 case ButtonState.loading:
//         //                   return Container(
//         //                     margin: EdgeInsets.all(8.0),
//         //                     width: 32.0,
//         //                     height: 32.0,
//         //                     child: CircularProgressIndicator(),
//         //                   );
//         //                 case ButtonState.paused:
//         //                   return IconButton(
//         //                     icon: Icon(Icons.play_arrow),
//         //                     iconSize: 32.0,
//         //                     onPressed: _pageManager.play,
//         //                   );
//         //                 case ButtonState.playing:
//         //                   return IconButton(
//         //                     icon: Icon(Icons.pause),
//         //                     iconSize: 32.0,
//         //                     onPressed: _pageManager.pause,
//         //                   );
//         //               }
//         //               return Container();
//         //             },
//         //           ),
//         //         ],
//         //       ),
//         //     ),
//         //   ),
//         // );
//         Scaffold(
//       key: scaffoldState,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(
//           'Now Playing',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 alignment: Alignment.topCenter,
//                 height: _appConfig.rHP(30),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                       StaticData.imagepath + 'bg.png',
//                     ),
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // tag: widget.image,
//                   Stack(
//                     children: [
//                       Container(
//                         width: _appConfig.rHP(30),
//                         height: _appConfig.rHP(30),
//                         decoration: BoxDecoration(
//                             // borderRadius: BorderRadius.circular(20),
//                             // color: Colors.red,
//                             ),
//                         margin: EdgeInsets.only(top: 10),
//                         alignment: Alignment.center,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(180.0),
//                           child: AnimatedBuilder(
//                             animation: _controller,
//                             builder: (_, child) => Transform.rotate(
//                               angle: _controller.value * 2 * pi,
//                               child: Image.network(
//                                 Networkutils.Baserl1 +
//                                     mostPlayedItem.musicimage,
//                                 fit: BoxFit.cover,
//                                 // height: _appConfig.rHP(20),
//                                 // width: _appConfig.rHP(20),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         right: 110,
//                         top: 118,
//                         child: Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 spreadRadius: 5,
//                                 blurRadius: 15,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 55,
//           ),
//           Container(
//             child: Text(
//               mostPlayedItem.musictitle,
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             child: Text(
//               mostPlayedItem.artistlist[0].artistname,
//               style: TextStyle(
//                 fontSize: 15,
//                 // fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           //  ValueListenableBuilder<ProgressBarState>(
//           //           valueListenable: _pageManager.progressNotifier,
//           //           builder: (_, value, __) {
//           //             return ProgressBar(
//           //               progress: value.current,
//           //               buffered: value.buffered,
//           //               total: value.total,
//           //               onSeek: _pageManager.seek,
//           //             );
//           //           },
//           //         ),
//           Slider.adaptive(
//             activeColor: Color(0xff6052DB),
//             inactiveColor: Colors.grey[350],
//             onChanged: (v) {
//               // final position = v * totalDuration.inMilliseconds;

//               // seekAudio(
//               //   Duration(
//               //     milliseconds: v.toInt(),
//               //   ),
//               // );
//               data = v;
//             },
//             value: _position.inMilliseconds.toDouble(),
//             max: 20,
//             // totalDuration == null
//             //     ? 20
//             //     : totalDuration.inMilliseconds.toDouble(),
//             min: 0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 _position != null ? '${_positionText ?? ''} ' : '0:00',
//               ),
//               Text(
//                 mostPlayedItem.musicduration == null
//                     ? ""
//                     : mostPlayedItem.musicduration,
//               ),
//             ],
//           ),
//         ],
//       ),
//       // Center(
//       //     child: Row(
//       //   children: <Widget>[
//       //     IconButton(
//       //       onPressed: () {
//       //         if (widget.index + 1 < widget.songs.length)
//       //           show(mostPlayedItem.musictitle,
//       //               mostPlayedItem.artistlist[0].artistname);
//       //         Navigator.of(context).pushReplacement(
//       //           MaterialPageRoute(
//       //             builder: (context) => Musicscreens(
//       //               widget.songs,
//       //               widget.index - 1,
//       //               1,
//       //             ),
//       //           ),
//       //         );
//       //       },
//       //       icon: Icon(
//       //         Icons.skip_previous,
//       //       ),
//       //     ),
//       //     IconButton(
//       //       onPressed: () {
//       //         play();
//       //         if (!playing) {
//       //           // playmusic(musicUrl);
//       //           setState(() {
//       //             playBtn = Icons.pause;
//       //             playing = true;
//       //           });
//       //         } else {
//       //           _audioPlayer.pause();
//       //           setState(() {
//       //             playBtn = Icons.play_arrow;
//       //             playing = false;
//       //           });
//       //         }
//       //       },
//       //       icon: Icon(
//       //         playing == true ? Icons.pause : Icons.play_arrow,
//       //       ),
//       //     ),
//       //     IconButton(
//       //       onPressed: () {
//       //         // _audioPlayer.pause();
//       //         if (widget.index + 1 < widget.songs.length)
//       //           show(mostPlayedItem.musictitle,
//       //               mostPlayedItem.artistlist[0].artistname);
//       //         Navigator.of(context).pushReplacement(
//       //           MaterialPageRoute(
//       //             builder: (context) => Musicscreens(
//       //               widget.songs,
//       //               widget.index + 1,
//       //               1,
//       //             ),
//       //           ),
//       //         );
//       //       },
//       //       icon: Icon(
//       //         Icons.skip_previous,
//       //       ),
//       //     )
//       //   ],
//       // )),
//     );
//   }
// }
