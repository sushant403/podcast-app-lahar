class Movie {
  String status;
  String message;
  String response;

  static List<MoviesItem> movie;

  Movie.getuserid(dynamic obj) {
    movie =
        obj.map<MoviesItem>((json) => new MoviesItem.fromJson(json)).toList();
  }
}

class MoviesItem {
  final String movieid;
  final String moviename;
  final String movieimage;
  final String likedCount;
  final int isliked;

  MoviesItem({
    this.movieid,
    this.movieimage,
    this.moviename,
    this.isliked,
    this.likedCount,
  });

  factory MoviesItem.fromJson(Map<String, dynamic> jsonMap) {
    return MoviesItem(
      movieid: jsonMap['movie_id'],
      movieimage: jsonMap['movie_image'],
      moviename: jsonMap['movie_name'],
      isliked: jsonMap['is_liked'],
      likedCount: jsonMap['likedCount'],
    );
  }
}
