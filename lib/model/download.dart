class Downloads {
  final int isallowdownloads;

  Downloads({this.isallowdownloads});

  factory Downloads.fromJson(Map<String, dynamic> jsonMap) {
    return Downloads(
      isallowdownloads: jsonMap['is_allow_downloads'],
    );
  }
}
