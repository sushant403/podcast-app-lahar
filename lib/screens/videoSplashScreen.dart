import 'dart:async';

import 'package:flutter/material.dart';
import 'package:songapp/screens/Home.dart';
import 'package:songapp/staticData.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  @override
  _VideoSplashScreenState createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  VideoPlayerController playerController;
  VoidCallback listener;
  @override
  void initState() {
    super.initState();
    // playerController =
    //     VideoPlayerController.asset(StaticData.imagepath + 'splash.mp4');
    listener = () {
      setState(() {});
    };
    initializeVideo();
    playerController.play();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 6);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    // if(isfirst==null)
    //   {
    //     isfirst=true;
    //   }
    // if (isfirst) {
    // Navigator.pushReplacement(
    //   context,
    //   new MaterialPageRoute(
    //     builder: (context) => new Login(),
    //   ),
    // );
    // } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
    // }
    //  Navigator.of(context).pushReplacementNamed('/ui.login');
  }

  void initializeVideo() {
    playerController =
        VideoPlayerController.asset(StaticData.imagepath + 'splash.mp4')
          ..initialize().then((_) {
            // Once the video has been loaded we play the video and set looping to true.
            playerController.play();
            playerController.setLooping(true);
            playerController.setVolume(0.0);
            playerController.play();
            // Ensure the first frame is shown after the video is initialized.
            setState(() {});
          });
  }

  @override
  void deactivate() {
    if (playerController != null) {
      playerController.setVolume(0.0);
      playerController.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (playerController != null) playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new AspectRatio(
            aspectRatio: 9 / 16,
            child: Container(
              child: playerController != null
                  ? VideoPlayer(
                      playerController,
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
