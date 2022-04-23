import 'package:flutter/material.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
import 'package:songapp/screens/music/music.dart';
import 'package:songapp/staticData.dart';

class PlaylistScreen extends StatefulWidget {
  final List image;
  final String playlistName;
  final String playlistId;
  PlaylistScreen(this.image, this.playlistName, this.playlistId);
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  Networkutils networkutils;
  AppConfig _appConfig;
  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    getmusic();
    index = 0;
    colors = [];
    // _update();
  }

  List<PaletteColor> colors;

  int index;
  // _update() async {
  //   final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
  //       NetworkImage(Networkutils.Baserl1 + widget.image[0]),
  //       size: Size(400, 400),
  //       maximumColorCount: 20);
  //   colors.add(
  //     generator.darkMutedColor != null
  //         ? generator.dominantColor
  //         : PaletteColor(Colors.blue, 2),
  //   );
  // if (widget.type == 'Album') {
  //   print(Networkutils.model.isliked.toString());
  // } else if (widget.type == 'PopularMovie') {
  //   print(Networkutils.movies.isliked.toString());
  // } else if (widget.type == 'Artist') {
  //   print(Networkutils.item.isliked.toString());
  // }
  // print(widget.id);
  // if (widget.album == 1) {
  //   _liked = true;
  // } else {
  //   _liked = false;
  // }
  //   setState(() {});
  // }

  // ignore: deprecated_member_use
  List<MostPlayedItem> music = List();
  void getmusic() async {
    await networkutils.playlistmusic(widget.playlistId);
    music = MostPlayed.homemostplaylist;
    setState(() {});
  }

  Widget musics(i) {
    _appConfig = AppConfig(context);
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
                  Networkutils.Baserl1 + music[i].musicimage,
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
                      music[i].musictitle,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    width: _appConfig.rW(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        music[i].isliked == 0
                            ? GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  width: _appConfig.rW(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      // like('1', 'Music', music[i].musicid);
                                      // music[i].isliked = 1;
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
                                      // unlike('1', 'Music', music[i].musicid);
                                      // music[i].isliked = 0;

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
                            music[i].likecount.toString(),
                            //style: recnttextview,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              music[i].albumname == ""
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                      width: _appConfig.rW(60),
                      child: music[i].artistlist.length > 0
                          ? Text(
                              music[i].artistlist[0].artistname,
                              //  style: recnttextview,
                              maxLines: 1,
                            )
                          : Text(""),
                    )
                  : music[i].artistlist.length == 0
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                          width: _appConfig.rW(60),
                          child: Text(
                            music[i].albumname,
                            //   style: recnttextview,
                            maxLines: 1,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                          width: _appConfig.rW(60),
                          child: Text(
                            music[i].albumname +
                                " - " +
                                music[i].artistlist[0].artistname,
                            maxLines: 1,
                          ),
                        ),
            ],
          ),
        ],
      ),
    );
  }

  Future showExitPopup(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are You Sure?'),
          content: Text('Are You Want to Remove this music from playlist!'),
          actions: <Widget>[
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: Colors.blueAccent,
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                await deletePlaylistMusic(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deletePlaylistMusic(String id) async {
    await networkutils.deleteMusic(id);
    getmusic();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PlayList',
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
                      height: 220,
                      // width: _appConfig.rHP(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // margin: EdgeInsets.only(top: 35),
                      alignment: Alignment.topCenter,
                      child: NineGridView(
                        width: 220,
                        height: 220,
                        padding: EdgeInsets.all(5),
                        space: 1,
                        arcAngle: 50,
                        initIndex: 1,
                        type: NineGridType.qqGp,
                        itemCount: widget.image.length,
                        itemBuilder: (ctx, i) => Container(
                          child: Image.network(
                            Networkutils.Baserl1 + widget.image[i].musicimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          music.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.purple,
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.59,
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.purple,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.purple
                        ],
                        stops: [
                          0.0,
                          0.0,
                          0.9,
                          1.0
                        ], // 10% purple, 80% transparent, 10% purple
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstOut,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: music.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Music(
                                  music,
                                  i,
                                  1,
                                ),
                              ),
                            );
                            print(music[i].musicid);
                          },
                          onLongPress: () async {
                            await showExitPopup(context, music[i].musicid);
                          },
                          child: musics(i),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
      // Column(
      //   // mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Container(
      //       padding: EdgeInsets.only(left: 20),
      //       child: Text(
      //         'Your Playlist Music',
      //         style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //     Container(
      //       alignment: Alignment.center,
      //       child: music.length == 0
      //           ? Center(
      //               child: CircularProgressIndicator(
      //                 strokeWidth: 2,
      //                 backgroundColor: Colors.purple,
      //               ),
      //             )
      //           : Container(
      //               padding: EdgeInsets.only(left: 10),
      //               height: MediaQuery.of(context).size.height - 400,
      //               child: ListView.builder(
      //                 padding: EdgeInsets.only(top: 15),
      //                 shrinkWrap: true,
      //                 physics: BouncingScrollPhysics(),
      //                 itemCount: music.length,
      //                 itemBuilder: (context, i) {
      //                   return GestureDetector(
      //                     onLongPress: () async {
      //                       await showExitPopup(context, music[i].musicid);
      //                     },
      //                     onTap: () {
      //                       // Navigator.of(context).push(new MaterialPageRoute(
      //                       // builder: (context) =>
      //                       // new NowPlaying(recetplay, i, 1)));
      //                       print(music[i].musicid);
      //                     },
      //                     child: musics(i),
      //                   );
      //                 },
      //               ),
      //             ),
      //     ),
      //   ],
      // ),
    );
  }
}
