class StarPicture {
  //A dictionary describing the image_set or planet that the response illustrates, completely determined by the structured endpoint.
  var resource;
  String title;
  DateTime returnedDate;
  String url;
  String hdUrl;
  String mediaType; // either 'image' or 'video'
  String explanation;
  String thumbnailUrl; // the url for the thumbnail of a video
  String copyright;

  StarPicture(
      {this.resource,
      this.title,
      this.returnedDate,
      this.url,
      this.hdUrl,
      this.mediaType,
      this.explanation,
      this.thumbnailUrl,
      this.copyright});

  StarPicture.fromJson(Map<String, dynamic> json) {
    resource = json['resource'];
    title = json['title'];
    returnedDate = DateTime.parse(json['date']);
    url = json['url'];
    hdUrl = json['hdurl'] ?? '';
    mediaType = json['media_type'];
    explanation = json['explanation'];
    thumbnailUrl = json['thumbnail_url'] ?? '';
    copyright = json['copyright'];
  }
}

class StarPictureRequest {
  DateTime dateTime;
  bool thumbnail;
}
