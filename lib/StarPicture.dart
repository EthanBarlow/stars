class StarPicture {
  //A dictionary describing the image_set or planet that the response illustrates, completely determined by the structured endpoint.
  final String title;
  final DateTime returnedDate;
  final String url;
  final String hdUrl;
  final String mediaType; // either 'image' or 'video'
  final String explanation;
  final String thumbnailUrl; // the url for the thumbnail of a video
  final String copyright;

  StarPicture({
    required this.title,
    required this.returnedDate,
    required this.url,
    required this.hdUrl,
    required this.mediaType,
    required this.explanation,
    required this.thumbnailUrl,
    required this.copyright,
  });

  static StarPicture fromJson(Map<String, dynamic> json) {
    String tempTitle = json['title'];
    DateTime tempReturnedDate = DateTime.parse(json['date']);
    String tempUrl = json['url'];
    String tempHdUrl = json['hdurl'] ?? '';
    String tempMediaType = json['media_type'];
    String tempExplanation = json['explanation'];
    String tempThumbnailUrl = json['thumbnail_url'] ?? '';
    String tempCopyright = json['copyright'];

    return StarPicture(
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