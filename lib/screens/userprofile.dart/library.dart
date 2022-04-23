import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/customRoute.dart';
import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
import 'package:songapp/model/HomeScreen/components/recommendedAlbum.dart';
import 'package:songapp/model/Playlist.dart';
import 'package:songapp/screens/Home.dart';
import 'package:songapp/screens/PlaylistScreen.dart';
import 'package:songapp/screens/userprofile.dart/favourite.dart';
import 'package:songapp/staticData.dart';

class Library extends StatefulWidget {
  // final List playlist;
  // final List album;
  // final List recomSong;
  // Library(this.playlist, this.album, this.recomSong);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  Widget playlists(count, i) {
    if (count == 0) {
      return Container(
        width: 140,
        height: 140,
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
        width: 140,
        height: 140,
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
          height: 55,
          width: 55,
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
        width: 140,
        height: 140,
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
                  height: 55,
                  width: 55,
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
                  height: 55,
                  width: 55,
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
        width: 140,
        height: 140,
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
                  height: 55,
                  width: 55,
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
                  height: 55,
                  width: 55,
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
                  height: 55,
                  width: 55,
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
                  height: 55,
                  width: 55,
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
        width: 140,
        height: 140,
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
                  height: 55,
                  width: 55,
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
                  height: 55,
                  width: 55,
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
                  height: 55,
                  width: 55,
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
                  height: 55,
                  width: 55,
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

  final textcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void addTx() async {
    final entertitle = textcontroller.text;
    _formkey.currentState.validate();
    if (entertitle.isEmpty) {
      return;
    }
    await networkutils.addPlaylist(entertitle);
    getPlaylist();

    Navigator.of(context).pop();
  }

  Future toast() {
    return Fluttertoast.showToast(
      msg: "PlayList title can't be empty!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future showExitPopup(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are You Sure?'),
          content: Text('Are You Want to Delete this playlist!'),
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
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.blueAccent,
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                await deletePlaylist(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Networkutils networkutils;
  Future<void> deletePlaylist(String id) async {
    await networkutils.deleteplaylist(id);
    getPlaylist();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    getPlaylist();
    getMusic();
    getAllAlbum();
  }

  // ignore: deprecated_member_use
  List<PlaylistItem> playlist = List();
  void getPlaylist() async {
    await networkutils.getPlaylist();
    playlist = Playlist.playlists;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<MostPlayedItem> recomSong = List();
  void getMusic() async {
    await networkutils.recommededMusic();
    recomSong = MostPlayed.homemostplaylist;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<RecommendedAlbumItem> recomAlbum = List();
  void getAllAlbum() async {
    await networkutils.recommededAlbum();
    recomAlbum = RecommendedAlbum.albumList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height > 850
              ? MediaQuery.of(context).size.height * 0.3
              : MediaQuery.of(context).size.height * 0.4,
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
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              spreadRadius: 0,
                              color: Colors.black12,
                            ),
                          ],
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
                          StaticData.imagepath + 'play_list.png',
                          scale: 1.9,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Own Playlist',
                          style: TextStyle(
                            color: Color.fromRGBO(153, 92, 228, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => showBottomSheet(
                          backgroundColor: Colors.blue,
                          context: context,
                          builder: (ctx) => SingleChildScrollView(
                            child: Container(
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Create New Playlist',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            textcontroller.text.isEmpty
                                                ? toast()
                                                : addTx();
                                          },
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        autofocus: true,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          hintText:
                                              'Be epic,add an awesome title',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        onEditingComplete: addTx,
                                        onSaved: (_) => addTx(),
                                        controller: textcontroller,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
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
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                playlist.length == 0
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Colors.purple,
                        ),
                      )
                    : Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: playlist.length,
                          itemBuilder: (ctx, i) => GestureDetector(
                            onLongPress: () async {
                              await showExitPopup(
                                context,
                                playlist[i].userplaylistid,
                              );
                            },
                            onTap: () {
                              playlist[i].imagesslist.length == 0
                                  ? Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => HomeScreen(),
                                      ),
                                    )
                                  : Navigator.of(context).push(
                                      CustomRoute(
                                        builder: (ctx) => PlaylistScreen(
                                          playlist[i].imagesslist,
                                          playlist[i].userplaylistname,
                                          playlist[i].userplaylistid,
                                        ),
                                      ),
                                    );
                              print(playlist[i].userplaylistid);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 155,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  playlists(playlist[i].musiccount, i),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    playlist[i].userplaylistname,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height >
                                                  850
                                              ? 20
                                              : 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Favourites(recomAlbum, recomSong),
      ],
    );
  }
}
