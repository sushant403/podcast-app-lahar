class PopularAlbum {
  String status;
  String message;
  String response;

  static List<PopularAlbumItem> popalbumlist;

  PopularAlbum.getuserid(dynamic obj) {
    popalbumlist = obj
        .map<PopularAlbumItem>((json) => new PopularAlbumItem.fromJson(json))
        .toList();
  }
}

class PopularAlbumItem {
  final String albumid;
  final String albumname;
  final String albumimage;
  final String viewCount;
  final int isliked;
  final int likecount;
  final int musiccount;

  PopularAlbumItem({
    this.albumid,
    this.albumname,
    this.albumimage,
    this.viewCount,
    this.musiccount,
    this.isliked,
    this.likecount,
  });

  factory PopularAlbumItem.fromJson(Map<String, dynamic> jsonMap) {
    return PopularAlbumItem(
      albumid: jsonMap['album_id'],
      albumname: jsonMap['album_name'],
      albumimage: jsonMap['album_image'],
      isliked: jsonMap['is_liked'],
      likecount: jsonMap['like_count'],
      musiccount: jsonMap['music_count'],
      viewCount: jsonMap['viewCount'],
    );
  }
}
