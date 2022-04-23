import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/customRoute.dart';
import 'package:songapp/screens/viewAlbum.dart';
import 'package:songapp/screens/viewAllAlbum.dart';
import 'package:songapp/staticData.dart';

// ignore: must_be_immutable
class Album extends StatelessWidget {
  final List album;
  Album(this.album);
  AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      // height: _appConfig.rH(32),
      child: Column(
        children: <Widget>[
          Container(
            height: _appConfig.rH(7),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
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
                    StaticData.imagepath + 'album.png',
                    // scale: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                  child: Text(
                    "Popular Albums",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ViewAllAlbumSceen()));
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
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height > 840
                ? _appConfig.rH(25)
                : _appConfig.rH(27),
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: album.length == 0
                ? Container()
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: album.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CustomRoute(
                              builder: (ctx) => ViewAlbumScreen(
                                album[index].albumid,
                                album[index].albumname,
                                album[index].albumimage,
                                album[index].viewCount,
                                album[index].isliked,
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
                                      tag: album[index].albumimage,
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            Networkutils.Baserl1 +
                                                album[index].albumimage,
                                            height: _appConfig.rH(18),
                                            width: _appConfig.rH(18),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        width: _appConfig.rWP(20),
                                        height: _appConfig.rHP(3),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            album[index].musiccount.toString() +
                                                " Songs",
                                            overflow: TextOverflow.ellipsis,
                                            textWidthBasis:
                                                TextWidthBasis.longestLine,
                                          ),
                                        ),
                                      ),
                                    )
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
                                      album[index].albumname,
                                      // style: regular2textstyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.perm_identity,
                                          color: Color(0xffAEAEAE),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            album[index].viewCount,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textWidthBasis:
                                                TextWidthBasis.longestLine,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
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
}
