import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/customRoute.dart';
import 'package:songapp/screens/music/music.dart';
import 'package:songapp/screens/viewAlbum.dart';
import 'package:songapp/staticData.dart';

// ignore: must_be_immutable
class Recommended extends StatelessWidget {
  final List recomSong;
  final List recomMovie;
  final List recomAlbum;
  Recommended(
    this.recomSong,
    this.recomMovie,
    this.recomAlbum,
  );

  Widget musiclist() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: _appConfig.rH(25),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: recomSong.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => Music(recomSong, index, 1),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                    width: _appConfig.rWP(35),
                    height: _appConfig.rHP(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              Networkutils.Baserl1 +
                                  recomSong[index].musicimage,
                              height: _appConfig.rH(15),
                              width: _appConfig.rH(15),
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
                            recomSong[index].musictitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ),
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

  Widget moviewlist() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: _appConfig.rH(25),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: recomMovie.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CustomRoute(
                        builder: (ctx) => ViewAlbumScreen(
                          recomMovie[index].movieid,
                          recomMovie[index].moviename,
                          recomMovie[index].movieimage,
                          '',
                          recomMovie[index].isliked,
                          'PopularMovie',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 0.0,
                    ),
                    width: _appConfig.rWP(35),
                    height: _appConfig.rHP(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              Networkutils.Baserl1 +
                                  recomMovie[index].movieimage,
                              height: _appConfig.rH(15),
                              width: _appConfig.rH(15),
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
                            recomMovie[index].moviename,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ),
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

  Widget albumlist() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: _appConfig.rH(25),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: recomAlbum.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CustomRoute(
                        builder: (ctx) => ViewAlbumScreen(
                          recomAlbum[index].albumid,
                          recomAlbum[index].albumname,
                          recomAlbum[index].albumimage,
                          '',
                          // recomAlbum[index].viewCount,
                          recomAlbum[index].isliked,
                          'Album',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                    width: _appConfig.rWP(35),
                    height: _appConfig.rHP(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              Networkutils.Baserl1 +
                                  recomAlbum[index].albumimage,
                              height: _appConfig.rH(15),
                              width: _appConfig.rH(15),
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
                            recomAlbum[index].albumname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ),
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

  AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 20, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(0, 239, 215, 1),
                                Color.fromRGBO(153, 92, 228, 1),
                              ],
                            ),
                          ),
                          height: _appConfig.rH(3.5),
                          width: _appConfig.rH(3.5),
                          child: Image.asset(StaticData.imagepath + 'like.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            "Recommended",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _appConfig.rHP(1),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                physics: BouncingScrollPhysics(),
                indicatorColor: Colors.deepPurple,
                labelColor: Colors.black,
                indicatorWeight: 5,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
                tabs: [
                  Tab(
                    text: 'Music',
                  ),
                  Tab(
                    text: 'Movies',
                  ),
                  Tab(
                    text: 'Album',
                  ),
                ],
              ),
            ),
            Container(
              height: _appConfig.rHP(25),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: TabBarView(
                children: <Widget>[
                  musiclist(),
                  moviewlist(),
                  albumlist(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
