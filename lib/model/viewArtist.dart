import 'HomeScreen/components/mostplayed.dart';

// class ViewArtist {
//   String status;
//   String message;
//   String response;

//   static List<ViewArtistItem> favList;

//   ViewArtist.getuserid(dynamic obj) {
//     favList = obj
//         .map<ViewArtistItem>((json) => new ViewArtistItem.fromJson(json))
//         .toList();
//   }
// }

class ViewArtistItem {
  final String artistid;
  final String artistname;
  final String artistimage;
  final int likedCount;
  int isliked;
  final List<MostPlayedItem> mostplay;

  ViewArtistItem({
    this.artistid,
    this.artistname,
    this.artistimage,
    this.likedCount,
    this.isliked,
    this.mostplay,
  });

  factory ViewArtistItem.fromJson(Map<String, dynamic> jsonMap) {
    var list = jsonMap['music_list'] as List;
    List<MostPlayedItem> lists =
        list.map((i) => MostPlayedItem.fromJson(i)).toList();
    return ViewArtistItem(
      artistid: jsonMap['artist_id'],
      artistname: jsonMap['artist_name'],
      artistimage: jsonMap['artist_image'],
      isliked: jsonMap['is_liked'],
      likedCount: jsonMap['like_count'],
      mostplay: lists,
    );
  }
}
