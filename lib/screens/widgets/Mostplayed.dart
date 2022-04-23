import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/screens/ViewMostPlay.dart';
import 'package:songapp/screens/music/music.dart';

class MostPlayed extends StatelessWidget {
  final List mostplay;
  MostPlayed(this.mostplay);

  @override
  Widget build(BuildContext context) {
    AppConfig _appConfig;
    _appConfig = AppConfig(context);
    return Container(
      height: _appConfig.rH(30),
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 239, 215, 1),
                        Color.fromRGBO(153, 92, 228, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: _appConfig.rH(3.5),
                  width: _appConfig.rH(3.5),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Most Played",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ViewMostPlayScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                      // color: Colors.red,
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color.fromRGBO(153, 92, 228, 1),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: _appConfig.rH(25),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: mostplay.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Music(
                          mostplay,
                          index,
                          1,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: _appConfig.rHP(19.5),
                    padding: EdgeInsets.only(left: 10.0),
                    height: _appConfig.rHP(23),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              Networkutils.Baserl1 + mostplay[index].musicimage,
                              width: _appConfig.rHP(17),
                              height: _appConfig.rHP(17),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            mostplay[index].musictitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            mostplay[index].artistlist[0].artistname,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
