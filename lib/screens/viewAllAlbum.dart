import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/model/HomeScreen/components/albumItem.dart';
import 'package:songapp/screens/viewAlbum.dart';

class ViewAllAlbumSceen extends StatefulWidget {
  @override
  _ViewAllAlbumSceenState createState() => _ViewAllAlbumSceenState();
}

class _ViewAllAlbumSceenState extends State<ViewAllAlbumSceen> {
  Networkutils networkutils;
  AppConfig _appConfig;
  var foregroundWidget = Container(
      alignment: AlignmentDirectional.center,
      child: CircularProgressIndicator());
  @override
  void initState() {
    super.initState();
    // _controller = ScrollController();
    // Timer(Duration(milliseconds: 3000),
    //     () => setState(() => foregroundWidget = null));
    networkutils = Networkutils();
    getAllAlbum();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // ignore: deprecated_member_use
  List<PopularAlbumItem> album = List();
  void getAllAlbum() async {
    await networkutils.getAllAlbum();
    album = PopularAlbum.popalbumlist;
    setState(() {});
  }

  Widget itemBuilder(context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewAlbumScreen(
              album[index].albumid,
              album[index].albumname,
              album[index].albumimage,
              '',
              album[index].isliked,
              "Album",
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
        width: _appConfig.rWP(32),
        height: _appConfig.rHP(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                  tag: album[index].albumimage,
                  child: Image.network(
                    Networkutils.Baserl1 + album[index].albumimage,
                    height: _appConfig.rH(15),
                    width: _appConfig.rH(15),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: Text(
                album[index].albumname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textWidthBasis: TextWidthBasis.longestLine,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'All Album',
                  style: TextStyle(
                    fontSize: _appConfig.rHP(3),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: album.length == 0
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.purple,
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.74),
              physics: BouncingScrollPhysics(),
              // controller: _controller,
              itemCount: album.length,
              itemBuilder: itemBuilder,
            ),
    );
  }
}
