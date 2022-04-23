class MostPlayed {
  String status;
  String message;
  String response;

  static List<MostPlayedItem> homemostplaylist;

  MostPlayed.getuserid(dynamic obj) {
    homemostplaylist = obj
        .map<MostPlayedItem>((json) => new MostPlayedItem.fromJson(json))
        .toList();
  }
}

class MostPlayedItem {
  final String musictitle;
  final String musicid;
  final String artistid;
  final String albumid;
  final String musicfile;
  final String musicimage;
  final String musicduration;
  final String playCount;
  int isinplaylist;
  int isliked;
  final int likecount;
  final String albumname;
  final List<Artists> artistlist;

  MostPlayedItem({
    this.musicid,
    this.musictitle,
    this.musicimage,
    this.musicduration,
    this.musicfile,
    this.isliked,
    this.likecount,
    this.albumname,
    this.artistlist,
    this.artistid,
    this.isinplaylist,
    this.albumid,
    this.playCount,
  });

  factory MostPlayedItem.fromJson(Map<String, dynamic> jsonMap) {
    var list = jsonMap['artists'] as List;
    // print(list.runtimeType);
    List<Artists> imagesList = list.map((i) => Artists.fromJson(i)).toList();

    return MostPlayedItem(
        musicduration: jsonMap['music_duration'],
        isliked: jsonMap['is_liked'],
        musicfile: jsonMap['music_file'],
        musicimage: jsonMap['music_image'],
        likecount: jsonMap['like_count'],
        musicid: jsonMap['music_id'],
        artistid: jsonMap['artist_id'],
        isinplaylist: jsonMap['is_in_playlist'],
        albumid: jsonMap['album_id'],
        playCount: jsonMap['playCount'],
        albumname: jsonMap['album_name'],
        artistlist: imagesList,
        musictitle: jsonMap['music_title']);
  }
}

class Artists {
  final String artistname;
  final String artistid;

  Artists({this.artistname, this.artistid});

  factory Artists.fromJson(Map<String, dynamic> jsonMap) {
    return Artists(
        artistname: jsonMap['artist_name'], artistid: jsonMap['artist_id']);
  }
}
