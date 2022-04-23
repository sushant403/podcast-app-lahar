import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/model/search.dart';
import 'package:songapp/screens/music/music.dart';
import 'package:songapp/screens/userprofile.dart/userProfileScreen.dart';
import 'package:songapp/screens/viewAlbum.dart';
import 'package:songapp/staticData.dart';
import 'package:songapp/model/Allcomponents.dart';
import 'package:songapp/model/HomeScreen/components/albumItem.dart';
import 'package:songapp/model/HomeScreen/components/bannerSlider.dart' as b;
import 'package:songapp/model/HomeScreen/components/favouriteArtist.dart';
import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
import 'package:songapp/model/HomeScreen/components/movie.dart';
import 'package:songapp/model/HomeScreen/components/recommendedAlbum.dart';
import 'package:songapp/model/HomeScreen/components/popularMovie.dart' as s;
import 'package:songapp/model/HomeScreen/components/mostplayed.dart' as m;
import 'package:songapp/screens/widgets/PopularMovie.dart';
import 'package:songapp/screens/widgets/Recommended.dart';
import 'package:songapp/screens/widgets/favourite.dart';
import 'package:songapp/screens/widgets/recentplay.dart';
import 'package:songapp/screens/widgets/Album.dart';
import 'package:songapp/screens/widgets/Banner.dart';
import 'package:songapp/screens/widgets/Mostplayed.dart' as b;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Networkutils networkutils;
  // ignore: deprecated_member_use
  List<AllComponentsItem> allItems = List();
  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    getallcomponents();
    getBanner();
    getmostplayed();
    getAlbum();
    getfavArtist();
    getrecent();
    recommended();
    popularMoviees();
    getsearch();
  }

  void getallcomponents() async {
    await networkutils.getallcomponents();
    allItems = AllComponents.list;
    setState(() {});
  }

  void getsearch() async {
    await networkutils.searchdata();
    search = Searches.searchlist;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<b.BannerSliderItem> banneritem = List();
  void getBanner() async {
    await networkutils.getBannerSlider();
    banneritem = b.Banner.bannersliderLIst;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<m.MostPlayedItem> mostplay = List();
  void getmostplayed() async {
    await networkutils.mostplayed();
    mostplay = m.MostPlayed.homemostplaylist;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<PopularAlbumItem> album = List();
  void getAlbum() async {
    await networkutils.getAlbum();
    album = PopularAlbum.popalbumlist;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<FavouriteArtistItem> favartist = List();
  void getfavArtist() async {
    await networkutils.getFavArtist();
    favartist = FavouriteArtist.favList;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<m.MostPlayedItem> recent = List();
  void getrecent() async {
    await networkutils.recentPlayed();
    recent = m.MostPlayed.homemostplaylist;
    // print('dadfadfadfaddadfs' + recent[0].artistlist[0].artistname);

    setState(() {});
  }

  // ignore: deprecated_member_use
  List<m.MostPlayedItem> recomSong = List();
  // ignore: deprecated_member_use
  List<MoviesItem> recomMovie = List();
  // ignore: deprecated_member_use
  List<RecommendedAlbumItem> recomAlbum = List();
  void recommended() async {
    await networkutils.recommededMusic();
    recomSong = MostPlayed.homemostplaylist;
    await networkutils.recommendedMovie();
    recomMovie = Movie.movie;
    await networkutils.recommededAlbum();
    recomAlbum = RecommendedAlbum.albumList;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<s.PopularMovieItem> popularMovies = List();
  void popularMoviees() async {
    await networkutils.movie();
    popularMovies = s.PopularMovie.movie;
    setState(() {});
  }

  Widget home(position) {
    if (allItems[position].homecomponentsname == 'Banner Slider')
      return BannerSlider(banneritem);
    if (allItems[position].homecomponentsname == 'Most Played')
      return b.MostPlayed(mostplay);
    if (allItems[position].homecomponentsname == 'Popular Albums')
      return Album(album);
    if (allItems[position].homecomponentsname == 'Favourite Artists')
      return FavouriteArtists();
    if (allItems[position].homecomponentsname == 'Recently Played')
      return RecentPlay(recent);
    if (allItems[position].homecomponentsname == 'Recommended Music')
      return Recommended(recomSong, recomMovie, recomAlbum);
    if (allItems[position].homecomponentsname == 'Recommended Album')
      return PopularMovie(popularMovies);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          )
        ],
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 300),
                pageBuilder: (ctx, animation, secondaryAnimation) =>
                    UserProfileSceen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: new Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(1.0, 0.0),
                      ).animate(secondaryAnimation),
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(13),
            child: Container(
              child: Image.asset(
                StaticData.imagepath + 'profile.png',
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          StaticData.imagepath + 'logo_name.png',
          scale: 2,
        ),
      ),
      body: allItems.length == 0
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.purple,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (ctx, i) {
                  print('object');
                  print(allItems.length);
                  return home(i);
                },
              ),
            ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? Container()
          : IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
              },
            ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // ignore: deprecated_member_use
  List<SearchesItem> searches = List();

  void movies(String id, context) async {
    await networkUtil.viewMovie(id).then((value) {});
    // ignore: unnecessary_statements
    Networkutils.movies.mostplay;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewAlbumScreen(
          Networkutils.movies.movieid,
          Networkutils.movies.moviename,
          Networkutils.movies.movieimage,
          Networkutils.movies.likecount.toString(),
          Networkutils.movies.isliked,
          "Movie",
        ),
      ),
    );
  }

  void artists(String id, context) async {
    await networkUtil.viewArtist(id).then((value) {});
    // ignore: unnecessary_statements
    Networkutils.item.mostplay;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewAlbumScreen(
          Networkutils.item.artistid,
          Networkutils.item.artistname,
          Networkutils.item.artistimage,
          '',
          Networkutils.item.isliked,
          "Artist",
        ),
      ),
    );
  }

  void album(String id, context) async {
    await networkUtil.getViewAlbum(id).then((value) {});
    // ignore: unnecessary_statements
    Networkutils.model.mostplay;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewAlbumScreen(
          Networkutils.model.albumid,
          Networkutils.model.albumname,
          Networkutils.model.albumimage,
          Networkutils.model.likecount.toString(),
          Networkutils.model.isliked,
          "Album",
        ),
      ),
    );
  }

  void music(String id, context) async {
    await networkUtil.getsingelMusic('1', id).then((value) {});

    recent.add(Networkutils.musicItem);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Music(recent, 0, 1),
      ),
    );
  }

  Networkutils networkUtil;
  // ignore: deprecated_member_use
  List<MostPlayedItem> recent = List();

  @override
  Widget buildResults(BuildContext context) {
    networkUtil = Networkutils();
    if (query.length < 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    searches.clear();
    for (int i = 0; i < Searches.searchlist.length; i++) {
      if (Searches.searchlist[i].searchtext.toLowerCase().contains(query)) {
        searches.add(Searches.searchlist[i]);
      }
    }
    icons(i) {
      if (searches[i].searchtype == 'music') {
        return Icon(Icons.music_note);
      }
      if (searches[i].searchtype == 'artist') {
        return Icon(Icons.person);
      }
      if (searches[i].searchtype == 'movie') {
        return Icon(Icons.movie);
      }
      if (searches[i].searchtype == 'album') {
        return Icon(Icons.music_video);
      }
    }

    return ListView.builder(
      itemCount: searches.length,
      itemBuilder: (context, index) {
        var result = searches[index];
        return GestureDetector(
          onTap: () {
            if (result.searchtype == "music") {
              music(result.id, context);
            } else if (result.searchtype == "artist") {
              artists(result.id, context);
            } else if (result.searchtype == "movie") {
              movies(result.id, context);
            } else if (result.searchtype == "album") {
              album(result.id, context);
            }
          },
          child: searches.length == 0
              ? Center(
                  child: Text('No data found'),
                )
              : Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey[300],
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        icons(index),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                result.searchtext,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5d5d5d),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Container(
                              child: Text(
                                result.searchtype,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[],
    );
  }
}

// ignore: deprecated_member_use
List<SearchesItem> search = List();
