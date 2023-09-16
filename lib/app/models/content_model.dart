class ContentModel {
  String? url;
  String? title;
  ContentModel({
    this.url,
    this.title,
  });

  // from firestore
  ContentModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}
