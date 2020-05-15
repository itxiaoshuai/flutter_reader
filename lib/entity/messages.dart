class Messages {
  String id;
  String corpid;
  String msg_type;
  String title;
  String content;
  String do_str;
  String created_time;
  String msg_name;
  String msg_icon;
  List<NextDo> next_do;

  static Messages fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Messages newsBean = Messages();
    newsBean.id = map['id'];
    newsBean.corpid = map['corpid'];
    newsBean.msg_type = map['msg_type'];
    newsBean.title = map['title'];
    newsBean.content = map['content'];
    newsBean.do_str = map['do_str'];
    newsBean.created_time = map['created_time'];
    newsBean.msg_name = map['msg_name'];
    newsBean.msg_icon = map['msg_icon'];
    newsBean.next_do = map['next_do'].cast<String>();
    newsBean.next_do = List()
      ..addAll((map['next_do'] as List ?? []).map((o) => NextDo.fromMap(o)));
    return newsBean;
  }




}

class NextDo {
  String key;
  String name;


  static NextDo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NextDo product = NextDo();
    product.key = map['key'];
    product.name = map['name'];

    return product;
  }

  Map toJson() => {
    "key": key,
    "name": name,
  };
}