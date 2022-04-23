import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/customRoute.dart';
import 'package:songapp/screens/music/music.dart';
import 'package:songapp/screens/viewAlbum.dart';
import 'package:songapp/staticData.dart';

// ignore: must_be_immutable
class Favourites extends StatelessWidget {
  final List album;
  final List recomSong;
  Favourites(this.album, this.recomSong);
  Widget songs(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: 500,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        // spreadRadius: 1,
                        offset: Offset.fromDirection(1, 20),
                        blurRadius: 30,
                        color: Colors.blueAccent.withOpacity(0.3),
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(79, 139, 241, 1),
                        Color.fromRGBO(153, 92, 228, 1),
                      ],
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Text(
                          'Play All',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.music_note,
                              color: Colors.orangeAccent,
                              size: 35,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => Music(
                                    recomSong,
                                    0,
                                    1,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.play_arrow,
                                color: Color.fromRGBO(79, 139, 241, 1),
                                size: 35,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 140,
                padding: EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width - 150,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: recomSong.length,
                  itemBuilder: (ctx, i) => Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => Music(
                              recomSong,
                              i,
                              1,
                            ),
                          ),
                        );
                        print(recomSong[i].musicimage);
                      },
                      child: Container(
                        height: 100,
                        width: 300,
                        child: Container(
                          height: 50,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              Networkutils.Baserl1 + recomSong[i].musicimage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 618,
          child: Image.asset(
            StaticData.imagepath + '2.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  AppConfig _appConfig;
  Widget albums(BuildContext context) {
    _appConfig = AppConfig(context);
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          // color: Colors.red,
          padding: EdgeInsets.only(top: 15),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: album.length,
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CustomRoute(
                    builder: (ctx) => ViewAlbumScreen(
                      album[i].albumid,
                      album[i].albumname,
                      album[i].albumimage,
                      '',
                      album[i].isliked,
                      'Album',
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 0.0,
                ),
                width: _appConfig.rHP(19.5),
                height: _appConfig.rHP(23),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: _appConfig.rHP(17),
                      height: _appConfig.rHP(17),
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: album[i].albumimage,
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  Networkutils.Baserl1 + album[i].albumimage,
                                  height: _appConfig.rH(18),
                                  width: _appConfig.rH(18),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 5, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            album[i].albumname,
                            // style: regular2textstyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 618,
          child: Image.asset(
            StaticData.imagepath + '2.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: MediaQuery.of(context).size.height - 358,
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                spreadRadius: 0,
                color: Colors.black12,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      // color: Colors.red,
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
                      child: Image.asset(
                        StaticData.imagepath + 'manager.png',
                        scale: 1.9,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Favourites',
                        style: TextStyle(
                          color: Color.fromRGBO(153, 92, 228, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      // color: Colors.red,
                      width: 150,
                      child: TabBar(
                        indicator: BoxDecoration(
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
                        physics: BouncingScrollPhysics(),
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.white,
                        tabs: [
                          Tab(
                            text: 'Songs',
                          ),
                          Tab(
                            text: 'Albums',
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.black,
                height: MediaQuery.of(context).size.height - 398,
                child: TabBarView(
                  children: [
                    recomSong.length == 0
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              backgroundColor: Colors.purple,
                            ),
                          )
                        : songs(context),
                    albums(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
