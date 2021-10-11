class Star {
  //A dictionary describing the image_set or planet that the response illustrates, completely determined by the structured endpoint.
  final String title;
  final DateTime returnedDate;
  final String url;
  final String hdUrl;
  final String mediaType; // either 'image' or 'video'
  final String explanation;
  final String thumbnailUrl; // the url for the thumbnail of a video
  final String copyright;
  bool userSaved = false;

  Star({
    required this.title,
    required this.returnedDate,
    required this.url,
    required this.hdUrl,
    required this.mediaType,
    required this.explanation,
    required this.thumbnailUrl,
    required this.copyright,
  });

  String get imgLink {
    if (this.hdUrl != '' && this.hdUrl != ' ') {
      return this.hdUrl;
    } else if (this.url != '' && this.url != ' ') {
      return this.url;
    } else {
      throw Error();
    }
  }

  bool get isCopyrighted =>
      this.copyright.isNotEmpty || this.copyright.length > 1;

  bool get hasRestrictions => isCopyrighted;

  static Star fromJson(Map<String, dynamic> json) {
    String tempTitle = json['title'];
    DateTime tempReturnedDate = DateTime.parse(json['date']);
    String tempUrl = json['url'];
    String tempHdUrl = json['hdurl'] ?? '';
    String tempMediaType = json['media_type'];
    String tempExplanation = json['explanation'];
    String tempThumbnailUrl = json['thumbnail_url'] ?? '';
    String tempCopyright = json['copyright'];

    return Star(
      title: tempTitle,
      returnedDate: tempReturnedDate,
      url: tempUrl,
      hdUrl: tempHdUrl,
      mediaType: tempMediaType,
      explanation: tempExplanation,
      thumbnailUrl: tempThumbnailUrl,
      copyright: tempCopyright,
    );
  }
}
