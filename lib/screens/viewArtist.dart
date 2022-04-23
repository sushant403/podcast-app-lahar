import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/model/HomeScreen/components/allArtists.dart';
import 'package:songapp/screens/viewAlbum.dart';

class ViewArtists extends StatefulWidget {
  @override
  _ViewArtistState createState() => _ViewArtistState();
}

class _ViewArtistState extends State<ViewArtists> {
  AppConfig appConfig;
  Networkutils networkutils;
  bool loading = false;

  // ignore: deprecated_member_use
  List<AllArtistsItem> artist = List();
  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    getAllArtistss();
  }

  void getAllArtistss() async {
    await networkutils.getAllArtist();
    artist = AllArtist.favList;
    setState(() {});
  }

  Future like(String id, liketype, liketypeId) async {
    loading = true;
    await networkutils.like(id, liketype, liketypeId);
    getAllArtistss();
    setState(() {
      loading = false;
    });
  }

  Future unlike(String id, liketype, liketypeId) async {
    loading = true;

    await networkutils.unlike(id, liketype, liketypeId);
    getAllArtistss();
    setState(() {
      loading = false;
    });
  }

  Widget aritistList() {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: appConfig.rH(80),
            child: artist.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.purple,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.7),
                    itemCount: artist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewAlbumScreen(
                                artist[index].artistid,
                                artist[index].artistname,
                                artist[index].artistimage,
                                '',
                                artist[index].isliked,
                                "Artist",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 0.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: appConfig.rHP(15),
                                height: appConfig.rHP(15),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          Networkutils.Baserl1 +
                                              artist[index].artistimage,
                                          height: appConfig.rH(18),
                                          width: appConfig.rH(18),
                                          fit: BoxFit.cover,
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
                                      artist[index].artistname,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: artist[index].isliked == 0
                                              ? GestureDetector(
                                                  onTap: () {
                                                    like(
                                                      '1',
                                                      'Artist',
                                                      artist[index].artistid,
                                                    );
                                                    artist[index].isliked = 1;
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    unlike(
                                                      '1',
                                                      'Artist',
                                                      artist[index].artistid,
                                                    );
                                                    artist[index].isliked = 0;
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Color.fromRGBO(
                                                        153, 92, 228, 1),
                                                  ),
                                                ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            artist[index].likedCount.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textWidthBasis:
                                                TextWidthBasis.longestLine,
                                          ),
                                        )
                                      ],
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
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Artists',
                style: TextStyle(
                  fontSize: appConfig.rHP(3),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: aritistList(),
    );
  }
}
