import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/model/Playlist.dart';

class Sheet extends StatefulWidget {
  // final Function newTx;

  // Sheet(this.newTx);

  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  final textcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Networkutils networkutils;
  @override
  void initState() {
    super.initState();
    networkutils = Networkutils();
    getPlaylist();
  }

  // ignore: deprecated_member_use
  List<PlaylistItem> playlist = List();
  void getPlaylist() async {
    await networkutils.getPlaylist();
    playlist = Playlist.playlists;
    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {
                      textcontroller.text.isEmpty ? toast() : addTx();
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
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Be epic,add an awesome title',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
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
    );
  }
}
