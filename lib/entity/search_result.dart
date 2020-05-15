class DomainSearch {
  String domain;
  String price;
  int reg;

  DomainSearch({this.domain, this.price, this.reg});

  DomainSearch.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    price = json['price'];
    reg = json['reg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['price'] = this.price;
    data['reg'] = this.reg;
    return data;
  }
}
