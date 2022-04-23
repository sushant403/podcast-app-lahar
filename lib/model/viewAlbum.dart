import 'HomeScreen/components/mostplayed.dart';

class MovieAlbumModel {
  final int likecount;
  final String albumname;
  final String artistid;
  final String albumid;
  final String albumimage;
  final String categoryname;
  final String moviename;
  int isliked;

  final List<MostPlayedItem> mostplay;

  MovieAlbumModel({
    this.albumimage,
    this.moviename,
    this.categoryname,
    this.isliked,
    this.likecount,
    this.albumname,
    this.mostplay,
    this.artistid,
    this.albumid,
  });

  factory MovieAlbumModel.fromJson(Map<String, dynamic> jsonMap) {
    var list = jsonMap['music_list'] as List;
    List<MostPlayedItem> lists =
        list.map((i) => MostPlayedItem.fromJson(i)).toList();

    return MovieAlbumModel(
      likecount: jsonMap['like_count'],
      albumimage: jsonMap['album_image'],
      artistid: jsonMap['artist_id'],
      categoryname: jsonMap['category_name'],
      isliked: jsonMap['is_liked'],
      albumid: jsonMap['album_id'],
      moviename: jsonMap['movie_name'],
      albumname: jsonMap['album_name'],
      mostplay: lists,
    );
  }
}
