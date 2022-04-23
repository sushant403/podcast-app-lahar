import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
import 'package:songapp/model/Playlist.dart';
import 'package:songapp/screens/music/music.dart';
import 'package:songapp/staticData.dart';

// ignore: must_be_immutable
class ViewMostPlayScreen extends StatefulWidget {
  @override
  _ViewMostPlayScreenState createState() => _ViewMostPlayScreenState();
}

class _ViewMostPlayScreenState extends State<ViewMostPlayScreen> {
  AppConfig _appConfig;
  Networkutils networkutils;
  // ignore: deprecated_member_use
  List<MostPlayedItem> mostplay = List();
  void addmusic(String playlistid, String musicid) async {
    await networkutils.addMusicinPlaylist(playlistid, musicid);
    getPlaylist();
    setState(() {});
  }

  Widget mostplaySong(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                child: Image.asset(StaticData.imagepath + 'back.png'),
              ),
              mostplay.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: Colors.purple,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 30),
                      child: CarouselSlider.builder(
                        itemCount: mostplay.length,
                        itemBuilder: (ctx, i, o) => Container(
                          // color: Colors.red,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              Networkutils.Baserl1 + mostplay[i].musicimage,
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          viewportFraction: 0.5,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, bottom: 20),
            child: Text(
              'All Songs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 410,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: mostplay.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.purple,
                    ),
                  )
                : ListView.builder(
                    itemCount: mostplay.length,
                    itemBuilder: (context, pos) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) => Music(
                                mostplay,
                                pos,
                                1,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 0, 10, 10),
                                child: Container(
                                  width: _appConfig.rH(6),
                                  height: _appConfig.rH(6),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      Networkutils.Baserl1 +
                                          mostplay[pos].musicimage,
                                      height: _appConfig.rH(6),
                                      width: _appConfig.rH(6),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: _appConfig.rW(53),
                                        child: Text(
                                          mostplay[pos].musictitle,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  mostplay[pos].albumname == ""
                                      ? Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 15),
                                          width: _appConfig.rW(60),
                                          child:
                                              mostplay[pos].artistlist.length >
                                                      0
                                                  ? Text(
                                                      mostplay[pos]
                                                          .artistlist[0]
                                                          .artistname,
                                                      maxLines: 1,
                                                    )
                                                  : Text(""),
                                        )
                                      : mostplay[pos].artistlist.length == 0
                                          ? Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 15),
                                              width: _appConfig.rW(60),
                                              child: Text(
                                                mostplay[pos].albumname,
                                                maxLines: 1,
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 15),
                                              width: _appConfig.rW(60),
                                              child: Text(
                                                mostplay[pos].albumname +
                                                    " - " +
                                                    mostplay[pos]
                                                        .artistlist[0]
                                                        .artistname,
                                                maxLines: 1,
                                              ),
                                            ),
                                ],
                              ),
                              Container(
                                // width: 0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    mostplay[pos].isliked == 0
                                        ? Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: GestureDetector(
                                              onTap: () {
                                                like('1', 'Music',
                                                    mostplay[pos].musicid);
                                                mostplay[pos].isliked = 1;
                                                print("jhjdhhdj");
                                              },
                                              child: Icon(
                                                Icons.favorite_border,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            // width: _appConfig.rW(8),
                                            child: GestureDetector(
                                              onTap: () {
                                                unlike(
                                                  "1",
                                                  "Music",
                                                  mostplay[pos].musicid,
                                                );
                                                mostplay[pos].isliked = 0;

                                                print("jhjdhhdj");
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    sheet(
                                      context,
                                      mostplay[pos].musicimage,
                                      mostplay[pos].musictitle,
                                      mostplay[pos].albumname,
                                      mostplay[pos].artistlist,
                                      pos,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future like(String id, liketype, liketypeId) async {
    await networkutils.like(id, liketype, liketypeId);
    allmusics();
    setState(() {});
  }

  Future unlike(String id, liketype, liketypeId) async {
    await networkutils.unlike(id, liketype, liketypeId);
    allmusics();
    setState(() {});
  }

  sheet(BuildContext context, String image, String name, String albumname,
      List artist, int pos) {
    showBottomSheet(
      elevation: 30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      backgroundColor: Color(212121),
      builder: (ctx) => Container(
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
                      Networkutils.Baserl1 + image,
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
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    mostplay[pos].albumname == ""
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                            width: _appConfig.rW(60),
                            child: mostplay[pos].artistlist.length > 0
                                ? Text(
                                    mostplay[pos].artistlist[0].artistname,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: 20,
                                    ),
                                  )
                                : Text(""),
                          )
                        : mostplay[pos].artistlist.length == 0
                            ? Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                                width: _appConfig.rW(60),
                                child: Text(
                                  mostplay[pos].albumname,
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
                                  mostplay[pos].albumname +
                                      " - " +
                                      mostplay[pos].artistlist[0].artistname,
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontSize: 20,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color.fromRGBO(73, 67, 77, 1),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.library_music_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'View Album',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color.fromRGBO(73, 67, 77, 1),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'View Artist',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
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
                              mostplay[i].musicid,
                            );
                            addmusic(
                              playlist[i].userplaylistid,
                              mostplay[i].musicid,
                            );
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
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
                          )
                          // : Container(),
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

  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    allmusics();
    getPlaylist();
  }

  void allmusics() async {
    await networkutils.allmusic();
    mostplay = MostPlayed.homemostplaylist;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<PlaylistItem> playlist = List();
  void getPlaylist() async {
    await networkutils.getPlaylist();
    playlist = Playlist.playlists;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rHP(7)),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Most Played Songs',
                  style: TextStyle(
                    fontSize: _appConfig.rHP(3),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: mostplaySong(context),
    );
  }
}
