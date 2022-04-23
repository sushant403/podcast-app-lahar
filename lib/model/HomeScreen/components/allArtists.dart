class AllArtist {
  String status;
  String message;
  String response;

  static List<AllArtistsItem> favList;

  AllArtist.getuserid(dynamic obj) {
    favList = obj
        .map<AllArtistsItem>((json) => AllArtistsItem.fromJson(json))
        .toList();
  }
}

class AllArtistsItem {
  final String artistid;
  final String artistname;
  final String artistimage;
  int likedCount;
  int isliked;

  AllArtistsItem({
    this.artistid,
    this.artistname,
    this.artistimage,
    this.likedCount,
    this.isliked,
  });

  factory AllArtistsItem.fromJson(Map<String, dynamic> jsonMap) {
    return AllArtistsItem(
      artistid: jsonMap['artist_id'],
      artistname: jsonMap['artist_name'],
      artistimage: jsonMap['artist_image'],
      isliked: jsonMap['is_liked'],
      likedCount: jsonMap['like_count'],
    );
  }
}
