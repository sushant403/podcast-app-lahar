import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/customRoute.dart';
import 'package:songapp/model/HomeScreen/components/popularMovie.dart';
import 'package:songapp/screens/viewAlbum.dart';

class ViewMovieScreen extends StatefulWidget {
  @override
  _ViewMovieScreenState createState() => _ViewMovieScreenState();
}

class _ViewMovieScreenState extends State<ViewMovieScreen> {
  AppConfig _appConfig;
  Networkutils networkutils;

  Widget viewMovies() {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: _appConfig.rH(80),
            child: movie.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.purple,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.75),
                    itemCount: movie.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CustomRoute(
                              builder: (context) => ViewAlbumScreen(
                                movie[index].movieid,
                                movie[index].moviename,
                                movie[index].movieimage,
                                movie[index].viewCount,
                                movie[index].isliked,
                                'PopularMovie',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 0.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: _appConfig.rHP(15),
                                height: _appConfig.rHP(15),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Hero(
                                          tag: movie[index].movieimage,
                                          child: Image.network(
                                            Networkutils.Baserl1 +
                                                movie[index].movieimage,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      movie[index].moviename,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ),
                                  ],
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

  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    getAllMovies();
  }

  // ignore: deprecated_member_use
  List<PopularMovieItem> movie = List();
  void getAllMovies() async {
    await networkutils.getAllMovies();
    movie = PopularMovie.movie;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rHP(7)),
        child: AppBar(
            backgroundColor: Colors.white,
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Movies',
                    style: TextStyle(
                        fontSize: _appConfig.rHP(3),
                        color: Colors.black,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
              onPressed: () => Navigator.pop(context, false),
            )),
      ),
      body: viewMovies(),
    );
  }
}
