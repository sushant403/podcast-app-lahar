import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
import 'package:songapp/staticData.dart';

import 'music/music.dart';

class ViewAlbumScreen extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String countview;
  final int album;
  final String type;
  ViewAlbumScreen(
    this.id,
    this.name,
    this.image,
    this.countview,
    this.album,
    this.type,
  );
  @override
  _ViewAlbumScreenState createState() => _ViewAlbumScreenState();
}

class _ViewAlbumScreenState extends State<ViewAlbumScreen> {
  Networkutils networkutils;
  // ignore: deprecated_member_use
  List<MostPlayedItem> music = List();
  AppConfig _appConfig;
  String image;
  List<PaletteColor> colors;
  int index;

  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    _update();
    if (widget.type == 'Album') {
      getAlbum();
    } else if (widget.type == 'PopularMovie') {
      getMovie();
    } else if (widget.type == 'Artist') {
      getArtistdata();
    }
    colors = [];
    index = 0;
  }

  bool _liked = false;
  _update() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        NetworkImage(Networkutils.Baserl1 + widget.image),
        size: Size(400, 400),
        maximumColorCount: 20);
    colors.add(
      generator.darkMutedColor != null
          ? generator.dominantColor
          : PaletteColor(Colors.blue, 2),
    );
    if (widget.type == 'Album') {
      print(Networkutils.model.isliked.toString());
    } else if (widget.type == 'PopularMovie') {
      print(Networkutils.movies.isliked.toString());
    } else if (widget.type == 'Artist') {
      print(Networkutils.item.isliked.toString());
    }
    print(widget.id);
    if (widget.album == 1) {
      _liked = true;
    } else {
      _liked = false;
    }
    setState(() {});
  }

  void _onpress() async {
    if (_liked) {
      await _like('1', 'Album', widget.id);
    } else {
      await _unlike('1', 'Album', widget.id);
    }
    if (widget.type == 'Album') {
      print(Networkutils.model.isliked.toString());
    } else if (widget.type == 'PopularMovie') {
      print(Networkutils.movies.isliked.toString());
    } else if (widget.type == 'Artist') {
      print(Networkutils.item.isliked.toString());
    }
  }

  void getAlbum() async {
    await networkutils.getViewAlbum(widget.id);
    music = Networkutils.model.mostplay;
    print(music[0]);
    setState(() {});
  }

  void getMovie() async {
    await networkutils.viewMovie(widget.id);
    music = Networkutils.movies.mostplay;
    print(music[0]);
    setState(() {});
  }

  void getArtistdata() async {
    await networkutils.viewArtist(widget.id);
    music = Networkutils.item.mostplay;
    print(music[0]);
    setState(() {});
  }

  Future _like(String id, liketype, liketypeId) async {
    await networkutils.like(id, liketype, liketypeId);
    if (widget.type == 'Album') {
      getAlbum();
    } else if (widget.type == 'PopularMovie') {
      getMovie();
    } else if (widget.type == 'Artist') {
      getArtistdata();
    }
    setState(() {});
  }

  Future _unlike(String id, liketype, liketypeId) async {
    await networkutils.unlike(id, liketype, liketypeId);
    if (widget.type == 'Album') {
      getAlbum();
    } else if (widget.type == 'PopularMovie') {
      getMovie();
    } else if (widget.type == 'Artist') {
      getArtistdata();
    }
    setState(() {});
  }

  Future like(String id, liketype, liketypeId) async {
    await networkutils.like(id, liketype, liketypeId);
    if (widget.type == 'Album') {
      getAlbum();
    } else if (widget.type == 'PopularMovie') {
      getMovie();
    } else if (widget.type == 'Artist') {
      getArtistdata();
    }
    setState(() {});
  }

  Future unlike(String id, liketype, liketypeId) async {
    await networkutils.unlike(id, liketype, liketypeId);
    if (widget.type == 'Album') {
      getAlbum();
    } else if (widget.type == 'PopularMovie') {
      getMovie();
    } else if (widget.type == 'Artist') {
      getArtistdata();
    }
    setState(() {});
  }

  Widget musics(pos) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 15, 10),
            child: Container(
              width: _appConfig.rH(6),
              height: _appConfig.rH(6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  Networkutils.Baserl1 + music[pos].musicimage,
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
                      music[pos].musictitle,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    width: _appConfig.rW(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        music[pos].isliked == 0
                            ? GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  width: _appConfig.rW(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      like('1', 'Music', music[pos].musicid);
                                      music[pos].isliked = 1;
                                    },
                                    child: Icon(
                                      Icons.favorite_outline,
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  width: _appConfig.rW(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      unlike('1', 'Music', music[pos].musicid);
                                      music[pos].isliked = 0;

                                      print("jhjdhhdj");
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            music[pos].likecount.toString(),
                            //style: recnttextview,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              music[pos].albumname == ""
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                      width: _appConfig.rW(60),
                      child: music[pos].artistlist.length > 0
                          ? Text(
                              music[pos].artistlist[0].artistname,
                              //  style: recnttextview,
                              maxLines: 1,
                            )
                          : Text(""),
                    )
                  : music[pos].artistlist.length == 0
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                          width: _appConfig.rW(60),
                          child: Text(
                            music[pos].albumname,
                            //   style: recnttextview,
                            maxLines: 1,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                          width: _appConfig.rW(60),
                          child: Text(
                            music[pos].albumname +
                                " - " +
                                music[pos].artistlist[0].artistname,
                            maxLines: 1,
                          ),
                        ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music Album',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  Hero(
                    tag: widget.image,
                    child: Container(
                      width: _appConfig.rHP(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset.fromDirection(2, 6),
                            spreadRadius: 3,
                            blurRadius: 25,
                            color: colors.isNotEmpty
                                ? colors[index].color.withOpacity(0.3)
                                : Colors.black12,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 35),
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          Networkutils.Baserl1 + widget.image,
                          height: _appConfig.rHP(20),
                          width: _appConfig.rHP(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: colors.isNotEmpty
                              ? colors[index].color
                              : Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.countview == '' || widget.countview == null
                            ? ""
                            : widget.countview + " Views",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Music(
                              music,
                              0,
                              1,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: _appConfig.rW(10),
                        height: _appConfig.rW(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 239, 215, 1),
                              Color.fromRGBO(153, 92, 228, 1),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _appConfig.rWP(2),
                    ),
                    // widget.islike == 0
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.grey)),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: _appConfig.rW(10),
                      height: _appConfig.rW(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _liked = !_liked;
                          });
                          _onpress();

                          print("jhjdhhdj");
                        },
                        child: _liked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.blueAccent,
                                size: 17,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: 17,
                              ),
                      ),
                    ),

                    SizedBox(
                      width: _appConfig.rWP(2),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: _appConfig.rW(10),
                        height: _appConfig.rW(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Icon(
                          Icons.download,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: _appConfig.rWP(3),
                    ),
                  ],
                )
              ],
            ),
          ),
          music.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.purple,
                  ),
                )
              : Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: music.length,
                      itemBuilder: (context, pos) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Music(music, pos, 1),
                              ),
                            );
                            print(music[pos].musicid);
                          },
                          onLongPress: () {},
                          child: musics(pos),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
