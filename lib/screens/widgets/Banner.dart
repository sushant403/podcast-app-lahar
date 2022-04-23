import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';

class BannerSlider extends StatelessWidget {
  final List banneritem;

  BannerSlider(this.banneritem);

  @override
  Widget build(BuildContext context) {
    AppConfig _appConfig;
    _appConfig = AppConfig(context);
    return Container(
      // color: Colors.red,
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        items: banneritem.map(
          (url) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Container(
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Image.network(
                            Networkutils.Baserl1 + url.bannersliderimage,
                            fit: BoxFit.cover,
                            // height: _appConfig.rHP(24),
                            // width: _appConfig.rWP(90),
                          ),
                        ),
                        url.bannersliderbuttonalignment == "Left"
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: _appConfig.rHP(20),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Color(0x00ffffff),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            width: _appConfig.rHP(22),
                                            child: Text(
                                              url.bannerslidername,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: _appConfig.rWP(5),
                                                  color: Colors.white),
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          url.bannerslidershowbutton == "0"
                                              ? Container()
                                              : Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  width: _appConfig.rWP(30),
                                                  height: _appConfig.rHP(3.5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      url.bannersliderbuttontext,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    // alignment: Alignment.bottomCenter,
                                    height: _appConfig.rHP(20),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Color(0x00ffffff),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              url.bannerslidername,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  // fontFamily: 'Montserrat',
                                                  color: Colors.white),
                                              maxLines: 2,
                                            ),
                                          ),
                                          url.bannerslidershowbutton == "0"
                                              ? Container()
                                              : Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  width: _appConfig.rWP(30),
                                                  height: _appConfig.rHP(3.5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      url.bannersliderbuttontext,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        // fontFamily: 'Montserrat',
                                                        fontSize:
                                                            _appConfig.rWP(3),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
        options: CarouselOptions(viewportFraction: 1, aspectRatio: 1),
      ),
    );
  }
}
