import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  final Function play;
  Play(this.play);
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 450,
      ),
    );
  }

  bool _isplay = true;

  AnimationController _animationController;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _isplay = !_isplay;
        if (!_isplay) _animationController.forward();
        if (_isplay) _animationController.reverse();
        widget.play();
        print('object');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.pause_play,
        progress: _animationController,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
