class Home {
  List<FirstBanner> first_banner;
  List<Null> second_banner;
  List<Product> product;
  WxShare wxShare;
  String copyright;
  String copyrightTech;

  static Home fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Home home = Home();
    home.first_banner = List()
      ..addAll((map['first_banner'] as List ?? [])
          .map((o) => FirstBanner.fromMap(o)));
    home.product = List()
      ..addAll((map['product'] as List ?? []).map((o) => Product.fromMap(o)));
    home.wxShare = map['wxShare'];
    home.wxShare =
        map['wx_share'] != null ? WxShare.fromMap(map['wx_share']) : null;
    home.copyright = map['copyright'];
    home.copyrightTech = map['copyright_tech'];
    return home;
  }
}

class FirstBanner {
  String banner;
  String action_type;
  String action_value;

  static FirstBanner fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FirstBanner firstBanner = FirstBanner();
    firstBanner.banner = map['banner'];
    firstBanner.action_type = map['action_type'];
    firstBanner.action_value = map['action_value'];
    print("firstBanner----+${firstBanner.banner}");
    return firstBanner;
  }

  Map toJson() => {
        "banner": banner,
        "action_type": action_type,
        "action_value": action_value,
      };
}

class Product {
  String id;
  String mark;
  String icon;
  String name;
  String head_img;
  String desc;

  static Product fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Product product = Product();
    product.id = map['id'];
    product.mark = map['mark'];
    product.icon = map['icon'];
    product.name = map['name'];
    product.head_img = map['head_img'];
    product.desc = map['desc'];
    print("product----+${product}");
    return product;
  }

  Map toJson() => {
        "id": id,
        "mark": mark,
        "icon": icon,
        "name": name,
        "head_img": head_img,
        "desc": desc,
      };
}

class WxShare {
  Config config;
  Value value;

  static WxShare fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WxShare wxShare = WxShare();
    wxShare.config =
        map['config'] != null ? Config.fromMap(map['config']) : null;
    wxShare.value = map['value'] != null ? Value.fromMap(map['value']) : null;

    return wxShare;
  }

  Map toJson() => {
        "config": config,
        "value": value,
      };
}

class Config {
  String appId;
  int timestamp;
  String nonceStr;
  String signature;
  String string;


  static Config fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Config config = Config();
    config.appId = map['appId'];
    config.timestamp = map['timestamp'];
    config.nonceStr = map['nonceStr'];
    config.signature = map['signature'];
    config.string = map['string'];
    return config;
  }

  Map toJson() => {
    "appId": appId,
    "timestamp": timestamp,
    "nonceStr": nonceStr,
    "signature": signature,
    "string": string,
  };
}

class Value {
  String title;
  String desc;
  String link;
  String imgUrl;
  String shareUrl;

  static Value fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Value value = Value();
    value.title = map['title'];
    value.desc = map['desc'];
    value.link = map['link'];
    value.imgUrl = map['imgUrl'];
    value.shareUrl = map['shareUrl'];
    return value;
  }

  Map toJson() => {
        "title": title,
        "desc": desc,
        "link": link,
        "imgUrl": imgUrl,
        "shareUrl": shareUrl,
      };
}
