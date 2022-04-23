import 'dart:io';
import 'dart:math';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/customRoute.dart';
import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
import 'package:songapp/model/Playlist.dart';
import 'package:songapp/screens/music/play.dart';
import 'package:songapp/screens/payment/choosePlanScreen.dart';
import 'package:songapp/staticData.dart';

// ignore: must_be_immutable
class Music extends StatefulWidget {
  int mode;
  List<MostPlayedItem> songs;
  int index;
  String image;

  Music(this.songs, this.index, this.mode, {this.image});
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> with SingleTickerProviderStateMixin {
  MostPlayedItem mostPlayedItem;
  String musicUrl = '';
  AudioPlayer _audioPlayer;
  AnimationController _controller;
  bool _isshuffle = false;
  final scaffoldState = GlobalKey<ScaffoldState>();

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
  @override
  void initState() {
    super.initState();
    mostPlayedItem = widget.songs[widget.index];
    musicUrl = Networkutils.Baserl1 + mostPlayedItem.musicfile;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();

    print(musicUrl);
    print('index is ' + widget.index.toString());
    print(widget.songs[0].musicid);
    networkutils = Networkutils();
    getPlaylist();
    _init();
    download();
    _audioPlayer.play();
  }

  void download() async {
    await networkutils.downloads();
    setState(() {});
  }

  void _init() async {
    // initialize the song
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(musicUrl);

    // listen for changes in player state
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    // listen for changes in play position
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    // listen for changes in the buffered position
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    // listen for changes in the total audio duration
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void play() async {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  // Future<void> show(title, author) async {
  //   try {
  //     await MediaNotification.showNotification(title: title, author: author);
  //     // setState(() => status = 'play');
  //     MediaNotification.setListener('pause', () {
  //       setState(() async {
  //         await _audioPlayer.pause();
  //       });
  //     });
  //     MediaNotification.setListener('next', () {
  //       setState(() {
  //         if (widget.index + 1 < widget.songs.length) {
  //           show(mostPlayedItem.musictitle,
  //               mostPlayedItem.artistlist[0].artistname);
  //           Navigator.of(context).pushReplacement(
  //             CustomRoute(
  //               builder: (context) => Music(
  //                 widget.songs,
  //                 widget.index + 1,
  //                 1,
  //               ),
  //             ),
  //           );
  //         } else {
  //           show(mostPlayedItem.musictitle,
  //               mostPlayedItem.artistlist[0].artistname);
  //           Navigator.of(context).pushReplacement(
  //             CustomRoute(
  //               builder: (context) => Music(
  //                 widget.songs,
  //                 widget.index - widget.songs.length + 1,
  //                 1,
  //               ),
  //             ),
  //           );
  //         }
  //       });
  //     });
  //     MediaNotification.setListener('prev', () {
  //       setState(() {
  //         if (widget.index + 1 < widget.songs.length) {
  //           show(mostPlayedItem.musictitle,
  //               mostPlayedItem.artistlist[0].artistname);
  //           Navigator.of(context).pushReplacement(
  //             CustomRoute(
  //               builder: (context) => Music(
  //                 widget.songs,
  //                 widget.index + 1,
  //                 1,
  //               ),
  //             ),
  //           );
  //         } else {
  //           show(mostPlayedItem.musictitle,
  //               mostPlayedItem.artistlist[0].artistname);
  //           Navigator.of(context).pushReplacement(
  //             CustomRoute(
  //               builder: (context) => Music(
  //                 widget.songs,
  //                 widget.index + widget.songs.length + 1,
  //                 1,
  //               ),
  //             ),
  //           );
  //         }
  //       });
  //     });
  //     await MediaNotification.setListener('play', () async {
  //       setState(() async {
  //         play();
  //         print('objects1');
  //       });
  //     });
  //   } on PlatformException {}
  // }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Widget dialog() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.purple,
      ),
    );
  }

  String _localPath;
  // ProgressDialog pr;
  double percentage = 0.0;
  bool downloading = false;
  var progress = "";

  Future<void> _download() async {
    _localPath = (await _findLocalPath()) + '/Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    // pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    dialog();

    Dio dio = Dio();

    var dirToSave = await getApplicationDocumentsDirectory();

    await dio.download(Networkutils.Baserl1 + mostPlayedItem.musicfile,
        "$_localPath/" + mostPlayedItem.musictitle + ".mp3",
        onReceiveProgress: (rec, total) {
      setState(() {
        downloading = true;

        // pr.show();
        dialog();

        Future.delayed(Duration(seconds: 2)).then((onvalue) {
          percentage = (percentage + 1.0);
          print("=======================>>>" + percentage.toString());
          print("${dirToSave.path}/" + mostPlayedItem.musictitle + ".mp3");
        });
      });
    });

    setState(() {
      downloading = false;
      print("${dirToSave.path}/" + mostPlayedItem.musictitle + ".mp3");
      progress = "Complete";
      Fluttertoast.showToast(
        msg: "Download Complated!" +
            "${dirToSave.path}/" +
            mostPlayedItem.musictitle +
            ".mp3",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      // pr.hide().whenComplete(() {});
    });
  }

  @override
  void dispose() async {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
    await MediaNotification.hideNotification();
  }

  Widget round(String image) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          width: 1,
          color: Colors.blueAccent,
        ),
      ),
      child: Image.asset(
        StaticData.imagepath + image + '.png',
        scale: 1.6,
      ),
    );
  }

  Widget round2(IconData image) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          width: 1,
          color: Colors.blueAccent,
        ),
      ),
      child: Icon(
        image,
        color: Colors.blueAccent,
      ),
    );
  }

  Future toast() {
    return Fluttertoast.showToast(
      msg: "Suffle is on",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // ignore: deprecated_member_use
  List<PlaylistItem> playlist = List();
  void getPlaylist() async {
    await networkutils.getPlaylist();
    playlist = Playlist.playlists;
    setState(() {});
  }

  Networkutils networkutils;
  // ignore: deprecated_member_use
  List<MostPlayedItem> mostplay = List();
  void addmusic(String playlistid, String musicid) async {
    await networkutils.addMusicinPlaylist(playlistid, musicid);
    getPlaylist();
    setState(() {});
  }

  Future like(String id, liketype, liketypeId) async {
    await networkutils.like(id, liketype, liketypeId);
    setState(() {});
  }

  Future unlike(String id, liketype, liketypeId) async {
    await networkutils.unlike(id, liketype, liketypeId);
    setState(() {});
  }

  Widget playlists(count, i) {
    if (count == 0) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add),
              Text('Add Some Music'),
            ],
          ),
        ),
      );
    } else if (count == 1) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Container(
          margin: EdgeInsets.all(7),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                Networkutils.Baserl1 + playlist[i].imagesslist[0].musicimage,
              ),
            ),
          ),
        ),
      );
    } else if (count == 2) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(7),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[0].musicimage,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[1].musicimage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (count == 3) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(7),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[0].musicimage,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[1].musicimage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(7),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[2].musicimage,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: EdgeInsets.all(7),
                  height: 45,
                  width: 45,
                  child: Icon(
                    Icons.play_arrow,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (count >= 4) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black12,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(7),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[0].musicimage,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[1].musicimage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 7, top: 7, bottom: 7),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        Networkutils.Baserl1 +
                            playlist[i].imagesslist[2].musicimage,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: EdgeInsets.only(
                    left: 7,
                    top: 7,
                    bottom: 7,
                  ),
                  height: 45,
                  width: 45,
                  child: Icon(
                    Icons.play_arrow,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container();
  }

  AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: _appConfig.rHP(30),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      StaticData.imagepath + 'bg.png',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: _appConfig.rHP(30),
                        height: _appConfig.rHP(30),
                        // decoration: BoxDecoration(color: Colors.red),
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(180.0),
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (_, child) => Transform.rotate(
                              angle: _controller.value * 2 * pi,
                              child: Image.network(
                                Networkutils.Baserl1 +
                                    mostPlayedItem.musicimage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 5,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 55,
          ),
          Container(
            child: Text(
              mostPlayedItem.musictitle,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          mostPlayedItem.albumname == ""
              ? Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                  width: _appConfig.rW(60),
                  child: mostPlayedItem.artistlist.length > 0
                      ? Text(
                          mostPlayedItem.artistlist[0].artistname,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: 20,
                          ),
                        )
                      : Text(""),
                )
              : mostPlayedItem.artistlist.length == 0
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                      width: _appConfig.rW(60),
                      child: Text(
                        mostPlayedItem.albumname,
                        style: TextStyle(
                          color: Colors.white,
                          // fontSize: 20,
                        ),
                        maxLines: 1,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                      width: _appConfig.rW(60),
                      child: Text(
                        mostPlayedItem.albumname +
                            " - " +
                            mostPlayedItem.artistlist[0].artistname,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ),
          // SizedBox(
          //   height: 30,
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height > 850
                ? MediaQuery.of(context).size.height * 0.08
                : 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  scaffoldState.currentState.showBottomSheet(
                    (context) => Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(60, 55, 61, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 70,
                                width: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    Networkutils.Baserl1 +
                                        mostPlayedItem.musicimage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      mostPlayedItem.musictitle,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  mostPlayedItem.albumname == ""
                                      ? Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 15),
                                          width: _appConfig.rW(60),
                                          child:
                                              mostPlayedItem.artistlist.length >
                                                      0
                                                  ? Text(
                                                      mostPlayedItem
                                                          .artistlist[0]
                                                          .artistname,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        // fontSize: 20,
                                                      ),
                                                    )
                                                  : Text(""),
                                        )
                                      : mostPlayedItem.artistlist.length == 0
                                          ? Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 15),
                                              width: _appConfig.rW(60),
                                              child: Text(
                                                mostPlayedItem.albumname,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  // fontSize: 20,
                                                ),
                                                maxLines: 1,
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 15),
                                              width: _appConfig.rW(60),
                                              child: Text(
                                                mostPlayedItem.albumname +
                                                    " - " +
                                                    mostPlayedItem.artistlist[0]
                                                        .artistname,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Add Song to...',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 680,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: playlist.length,
                              itemBuilder: (ctx, i) => Container(
                                alignment: Alignment.center,
                                width: 135,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    playlists(playlist[i].musiccount, i),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                          playlist[i].userplaylistid,
                                        );
                                        print(
                                          mostPlayedItem.musicid,
                                        );
                                        addmusic(
                                          playlist[i].userplaylistid,
                                          mostPlayedItem.musicid,
                                        );
                                      },
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: Color.fromRGBO(73, 67, 77, 1),
                                        ),
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: round('ic_add_playlist'),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isshuffle = !_isshuffle;
                  });
                  print(_isshuffle);
                  if (_isshuffle == true)
                    _audioPlayer.setShuffleModeEnabled(true);

                  if (_isshuffle == true) toast();
                  if (_isshuffle == false) print('object');
                },
                child: round(_isshuffle ? 'ic_suffle' : 'ic_suffle2'),
              ),
              mostPlayedItem.isliked == 0
                  ? GestureDetector(
                      onTap: () {
                        like('1', 'Music', mostPlayedItem.musicid);
                        mostPlayedItem.isliked = 1;
                        print("jhjdhhdj");
                      },
                      child: round2(Icons.favorite_border),
                    )
                  : GestureDetector(
                      onTap: () {
                        unlike('1', 'Music', mostPlayedItem.musicid);
                        mostPlayedItem.isliked = 0;
                        print("jhjdhhdj");
                      },
                      child: round2(Icons.favorite),
                    ),
              GestureDetector(
                onTap: () {
                  if (Networkutils.download == 1) {
                    _download();
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ChoosePlanScreen(),
                      ),
                    );
                  }
                },
                child: round2(Icons.download),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height > 850
                ? MediaQuery.of(context).size.height * 0.03
                : 0,
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ValueListenableBuilder<ProgressBarState>(
              valueListenable: progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                  barHeight: 2,
                  progressBarColor: Colors.blueAccent,
                  thumbColor: Colors.blueAccent,
                  thumbRadius: 7,
                  bufferedBarColor: Colors.blueAccent.withOpacity(0.4),
                  progress: value.current,
                  buffered: value.buffered,
                  total: value.total,
                  onSeek: seek,
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                height: 55,
                width: 55,
                child: IconButton(
                  onPressed: () {
                    if (widget.index == 0) {
                      return;
                    } else {
                      // show(mostPlayedItem.musictitle,
                      //     mostPlayedItem.artistlist[0].artistname);
                      Navigator.of(context).pushReplacement(
                        CustomRoute(
                          builder: (context) => Music(
                            widget.songs,
                            widget.index - widget.songs.length + 1,
                            1,
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.skip_previous,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  // color: Colors.red,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 239, 215, 1),
                      Color.fromRGBO(153, 92, 228, 1),
                    ],
                  ),
                ),
                height: 60,
                width: 60,
                child: ValueListenableBuilder<ButtonState>(
                  valueListenable: buttonNotifier,
                  builder: (_, value, __) {
                    switch (value) {
                      case ButtonState.loading:
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          width: 32.0,
                          height: 32.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: Colors.purple,
                          ),
                        );
                      case ButtonState.paused:
                        return Play(play);

                      case ButtonState.playing:
                        return Play(pause);
                    }
                    return Container();
                  },
                ),
              ),
              Container(
                height: 55,
                width: 55,
                child: IconButton(
                  onPressed: () {
                    if (widget.index + 1 < widget.songs.length) {
                      // show(mostPlayedItem.musictitle,
                      //     mostPlayedItem.artistlist[0].artistname);
                      Navigator.of(context).pushReplacement(
                        CustomRoute(
                          builder: (context) => Music(
                            widget.songs,
                            widget.index + 1,
                            1,
                          ),
                        ),
                      );
                    } else {
                      // show(mostPlayedItem.musictitle,
                      //     mostPlayedItem.artistlist[0].artistname);
                      Navigator.of(context).pushReplacement(
                        CustomRoute(
                          builder: (context) => Music(
                            widget.songs,
                            widget.index - widget.songs.length + 1,
                            1,
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.skip_next,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ],
      ),
    );
  }
}

class ProgressBarState {
  ProgressBarState({
    this.current,
    this.buffered,
    this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
