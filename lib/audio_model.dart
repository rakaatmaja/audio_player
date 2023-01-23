class AudioNiat {
  String? name;
  String? url;

  AudioNiat({
    this.name,
    this.url,
  });

  AudioNiat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
