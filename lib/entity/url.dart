class Url {
  String url;

  static Url fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Url bean = Url();
    bean.url = map['url'];

    return bean;
  }

  Map toJson() => {
        "url": url,
      };
}
