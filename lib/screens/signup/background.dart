import 'package:flutter/material.dart';
import 'package:songapp/staticData.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              StaticData.imagepath + 'sceen.png',
              // fit: BoxFit.cover,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
