import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/screens/viewAlbum.dart';
import 'package:songapp/screens/viewMovie.dart';
import 'package:songapp/staticData.dart';

class PopularMovie extends StatelessWidget {
  final List popularMovies;
  PopularMovie(this.popularMovies);

  @override
  Widget build(BuildContext context) {
    AppConfig _appConfig;
    _appConfig = AppConfig(context);
    return Container(
      // color: Colors.blue,
      height:
          // MediaQuery.of(context).size.height > 840
          // ? _
          _appConfig.rH(40),
      // : _appConfig.rH(40),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                  child: Image.asset(StaticData.imagepath + 'fire.png'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Popular Movie",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ViewMovieScreen(),
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
                )
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rHP(3),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
              // height: _appConfig.rH(30),
              child: popularMovies.length == 0
                  ? Container()
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: popularMovies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ViewAlbumScreen(
                                  popularMovies[index].movieid,
                                  popularMovies[index].moviename,
                                  popularMovies[index].movieimage,
                                  popularMovies[index].viewCount,
                                  popularMovies[index].isliked,
                                  'PopularMovie',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 9,
                                  color: Colors.black12,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 6.0,
                            ),
                            width: _appConfig.rHP(20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: Hero(
                                            tag:
                                                popularMovies[index].movieimage,
                                            child: Image.network(
                                              Networkutils.Baserl1 +
                                                  popularMovies[index]
                                                      .movieimage,
                                              height: _appConfig.rH(22),
                                              width: _appConfig.rH(20),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 5, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        popularMovies[index].moviename,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.perm_identity,
                                            size: 20,
                                            color: Color(0xffAEAEAE),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              popularMovies[index]
                                                  .viewCount
                                                  .toString(),
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
          )
        ],
      ),
    );
  }
}
