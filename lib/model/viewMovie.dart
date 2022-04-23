import 'HomeScreen/components/mostplayed.dart';

class ViewMovie {
  final int likecount;
  final String albumname;
  final String moviedescription;
  final String movieid;
  final String movieimage;
  final String movieyear;
  final String moviename;
  int isliked;

  final List<MostPlayedItem> mostplay;

  ViewMovie({
    this.movieimage,
    this.moviename,
    this.moviedescription,
    this.isliked,
    this.likecount,
    this.albumname,
    this.mostplay,
    this.movieid,
    this.movieyear,
  });

  factory ViewMovie.fromJson(Map<String, dynamic> jsonMap) {
    var list = jsonMap['music_list'] as List;
    print(list.runtimeType);
    List<MostPlayedItem> imagesList =
        list.map((i) => MostPlayedItem.fromJson(i)).toList();

    return ViewMovie(
      isliked: jsonMap['is_liked'],
      likecount: jsonMap['like_count'],
      moviedescription: jsonMap['movie_description'],
      movieid: jsonMap['movie_id'],
      movieimage: jsonMap['movie_image'],
      movieyear: jsonMap['movie_year'],
      moviename: jsonMap['movie_name'],
      albumname: jsonMap['album_name'],
      mostplay: imagesList,
    );
  }
}
