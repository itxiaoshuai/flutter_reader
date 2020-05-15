class ApplyList {
  String id;
  String productid;
  String productName;
  String productMark;
  String keyword;
  String feetype;
  String year;
  String price;
  String verifyFee;
  String otherClassFee;
  String total;
  String bs_name;
  List<ClassDetail> classDetail;
  String materialType;
  List<Material> material;
  Subject subject;
  int expires;

  ApplyList(
      {this.id,
      this.productid,
      this.productName,
      this.productMark,
      this.keyword,
      this.feetype,
      this.year,
      this.price,
      this.verifyFee,
      this.otherClassFee,
      this.total,
      this.classDetail,
      this.materialType,
      this.material,
      this.subject,
      this.expires,this.bs_name});

  ApplyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productid = json['productid'];
    productName = json['product_name'];
    productMark = json['product_mark'];
    keyword = json['keyword'];
    feetype = json['feetype'];
    year = json['year'];
    price = json['price'];
    verifyFee = json['verify_fee'];
    otherClassFee = json['other_class_fee'];
    total = json['total'];
    bs_name = json['bs_name'];
    if (json['class_detail'] != null) {
      classDetail = new List<ClassDetail>();
      json['class_detail'].forEach((v) {
        classDetail.add(new ClassDetail.fromJson(v));
      });
    }
    materialType = json['material_type'];
    if (json['material'] != null) {
      material = new List<Material>();
      json['material'].forEach((v) {
        material.add(new Material.fromJson(v));
      });
    }
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productid'] = this.productid;
    data['product_name'] = this.productName;
    data['product_mark'] = this.productMark;
    data['keyword'] = this.keyword;
    data['feetype'] = this.feetype;
    data['year'] = this.year;
    data['price'] = this.price;
    data['verify_fee'] = this.verifyFee;
    data['other_class_fee'] = this.otherClassFee;
    data['total'] = this.total;
    if (this.classDetail != null) {
      data['class_detail'] = this.classDetail.map((v) => v.toJson()).toList();
    }
    data['material_type'] = this.materialType;
    if (this.material != null) {
      data['material'] = this.material.map((v) => v.toJson()).toList();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    data['expires'] = this.expires;
    return data;
  }
}

class ClassDetail {
  String categoryName;
  List<Detail> detail;

  ClassDetail({this.categoryName, this.detail});

  ClassDetail.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String code;
  List<Products> products;

  Detail({this.code, this.products});

  Detail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String id;
  String name;

  Products({this.id, this.name});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Material {
  String fileurl;

  Material({this.fileurl});

  Material.fromJson(Map<String, dynamic> json) {
    fileurl = json['fileurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileurl'] = this.fileurl;
    return data;
  }
}

class Subject {
  String address;
  String area;
  String city;
  String email;
  String id;
  String linkman;
  String name;
  String phone;
  String province;

  Subject(
      {this.address,
      this.area,
      this.city,
      this.email,
      this.id,
      this.linkman,
      this.name,
      this.phone,
      this.province});

  Subject.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    area = json['area'];
    city = json['city'];
    email = json['email'];
    id = json['id'];
    linkman = json['linkman'];
    name = json['name'];
    phone = json['phone'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['area'] = this.area;
    data['city'] = this.city;
    data['email'] = this.email;
    data['id'] = this.id;
    data['linkman'] = this.linkman;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['province'] = this.province;
    return data;
  }
}
