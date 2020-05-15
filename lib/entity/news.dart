class News {
  String id;
  String title;
  String summary;
  String url;
  String views;
  String src;
  String show_type;
  String time;
  List<String> imgs;

  static News fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    News newsBean = News();
    newsBean.id = map['id'];
    newsBean.title = map['title'];
    newsBean.summary = map['summary'];
    newsBean.url = map['url'];
    newsBean.views = map['views'];
    newsBean.src = map['src'];
    newsBean.show_type = map['show_type'];
    newsBean.time = map['time'];
    newsBean.imgs = map['imgs'].cast<String>();
    return newsBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "summary": summary,
        "url": url,
        "views": views,
        "src": src,
        "show_type": show_type,
        "time": time,
        "imgs": imgs,
      };
}
