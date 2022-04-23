import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/model/HomeScreen/components/favouriteArtist.dart';
import 'package:songapp/screens/viewArtist.dart';
import 'package:songapp/staticData.dart';

// ignore: must_be_immutable
class FavouriteArtists extends StatefulWidget {
  // final List favartist;
  // final Function artist;
  // FavouriteArtists(this.favartist, this.artist);

  @override
  _FavouriteArtistsState createState() => _FavouriteArtistsState();
}

class _FavouriteArtistsState extends State<FavouriteArtists> {
  AppConfig _appConfig;
  Networkutils networkutils;

  Future like(String id, liketype, liketypeId) async {
    await networkutils.like(id, liketype, liketypeId);
    getfavArtist();
    setState(() {});
  }

  Future unlike(String id, liketype, liketypeId) async {
    await networkutils.unlike(id, liketype, liketypeId);
    getfavArtist();
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<FavouriteArtistItem> favartist = List();
  void getfavArtist() async {
    await networkutils.getFavArtist();
    favartist = FavouriteArtist.favList;
    setState(() {});
  }

  Widget favlistartist(pos) {
    return GestureDetector(
      onTap: () {
        // Navigator.o
      },
      child: Container(
        width: _appConfig.rW(35),
        height: _appConfig.rHP(40),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(7),
                  height: _appConfig.rW(22),
                  width: _appConfig.rW(22),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                        Networkutils.Baserl1 + favartist[pos].artistimage,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _appConfig.rW(27),
                  height: _appConfig.rHP(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: _appConfig.rW(10),
                        width: _appConfig.rW(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2.0, color: const Color(0xffF6F6F6)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.0, 1.0],
                            colors: [
                              const Color(0xFF4F8BF1),
                              const Color(0xFF995CE4),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            favartist[pos].likedCount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: _appConfig.rW(22),
                    child: Text(
                      favartist[pos].artistname,
                      overflow: TextOverflow.ellipsis,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                        wordSpacing: 0.1,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: _appConfig.rW(8),
                  child: favartist[pos].isliked == 0
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              like(
                                "1",
                                "Artist",
                                favartist[pos].artistid,
                              );
                              favartist[pos].isliked = 1;
                            },
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Color.fromRGBO(153, 92, 228, 1),
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: _appConfig.rW(8),
                          child: GestureDetector(
                            onTap: () {
                              unlike(
                                "1",
                                "Artist",
                                favartist[pos].artistid,
                              );
                              favartist[pos].isliked = 0;
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Color.fromRGBO(153, 92, 228, 1),
                            ),
                          ),
                        ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    getfavArtist();
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5, 15, 0, 0),
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
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(0, 239, 215, 1),
                              Color.fromRGBO(153, 92, 228, 1),
                            ],
                          ),
                        ),
                        height: _appConfig.rH(3.5),
                        width: _appConfig.rH(3.5),
                        child: Image.asset(
                          StaticData.imagepath + 'manager.png',
                          scale: 1.9,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Favourite Artists",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (context) => ViewArtists(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color.fromRGBO(153, 92, 228, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rHP(1.5),
          ),
          Container(
            height: _appConfig.rHP(19),
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: favartist.length == 0
                ? Container(
                    alignment: Alignment.center,
                    child: Text('No Favourites yet!'),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: favartist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return favlistartist(index);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
