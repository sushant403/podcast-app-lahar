import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/model/HomeScreen/components/favouriteArtist.dart';
import 'package:songapp/model/HomeScreen/components/mostplayed.dart';
import 'package:songapp/screens/userprofile.dart/artist.dart' as a;
import 'package:songapp/screens/userprofile.dart/editprofileScreen.dart';
import 'package:songapp/screens/userprofile.dart/library.dart';
import 'package:songapp/screens/userprofile.dart/recent.dart';
import 'package:songapp/staticData.dart';

class UserProfileSceen extends StatefulWidget {
  @override
  _UserProfileSceenState createState() => _UserProfileSceenState();
}

class _UserProfileSceenState extends State<UserProfileSceen> {
  Networkutils networkutils;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _selectWidgetPosition(_key1));
    networkutils = Networkutils();
    // getPlaylist();
    // getAllAlbum();
    // getMusic();
    getrecent();
    getfavArtist();
  }

  int _currentselection = 1;
  GlobalKey _key1 = GlobalKey();
  GlobalKey _key2 = GlobalKey();
  GlobalKey _key3 = GlobalKey();
  final double _selectorWidth = 30.0;
  double _selectorPosiontX = 53.0;
  _selectedItem(int i) {
    _currentselection = i;
    GlobalKey _selectedglobalkey;
    switch (i) {
      case 1:
        _selectedglobalkey = _key1;
        break;
      case 2:
        _selectedglobalkey = _key2;
        break;
      case 3:
        _selectedglobalkey = _key3;
        break;
      default:
    }
    _selectWidgetPosition(_selectedglobalkey);
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<MostPlayedItem> recent = List();
  void getrecent() async {
    await networkutils.recentPlayed();
    recent = MostPlayed.homemostplaylist;
    setState(() {});
  }

  _selectWidgetPosition(GlobalKey selectedKey) {
    final RenderBox renderBox = selectedKey.currentContext.findRenderObject();
    final widgetposition = renderBox.localToGlobal(Offset.zero);
    final widgetsize = renderBox.size;
    _selectorPosiontX =
        widgetposition.dx - ((_selectorWidth - widgetsize.width) / 2);
  }

  // ignore: deprecated_member_use
  List<FavouriteArtistItem> favartist = List();
  void getfavArtist() async {
    await networkutils.getFavArtist();
    favartist = FavouriteArtist.favList;
    setState(() {});
  }

  Widget items() {
    if (_currentselection == 1) return Library();
    if (_currentselection == 2) return a.Artists(favartist);
    if (_currentselection == 3) return Recent(recent);
    return Container();
  }

  Widget artists() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Container(
          height: 100,
          width: 200,
          color: Colors.red,
          child: Card(),
        ),
      ],
    );
  }

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        backdropEnabled: true,
        backdropColor: Colors.black,
        maxHeight: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        minHeight: MediaQuery.of(context).size.height - 230,
        panel: Container(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    key: _key1,
                    onTap: () => _selectedItem(1),
                    child: Container(
                      height: 30,
                      width: 49,
                      child: FittedBox(
                        child: Text(
                          'Library',
                          style: _currentselection == 1
                              ? TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )
                              : TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    key: _key2,
                    onTap: () => _selectedItem(2),
                    child: Container(
                      height: 30,
                      width: 55,
                      // color: Colors.red,
                      child: FittedBox(
                        child: Text(
                          'Artists',
                          style: _currentselection == 2
                              ? TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )
                              : TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    key: _key3,
                    onTap: () => _selectedItem(3),
                    child: Container(
                      height: 30,
                      width: 48,
                      child: FittedBox(
                        child: Text(
                          'Recent',
                          style: _currentselection == 3
                              ? TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )
                              : TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                left: _selectorPosiontX,
                top: 25,
                child: Container(
                  height: 3,
                  width: _selectorWidth,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              items(),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(StaticData.imagepath + 'banner.png'),
              fit: BoxFit.fill,
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(47, 11, 69, 1),
                Color.fromRGBO(19, 13, 75, 1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top + 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'User Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 55,
                  )
                ],
              ),
              SizedBox(
                height: 17,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => EditProfileScreen(),
                    ),
                  );
                  print('sadfas');
                },
                child: Container(
                  // color: Colors.red,
                  margin: EdgeInsets.only(right: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        child: Image.asset(
                          StaticData.imagepath + 'profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 45,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                    clipBehavior: Clip.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Text(
                  'Nitika Bhatta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Text(
                  'nitika.bhatta@kathford.edu.np',
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
