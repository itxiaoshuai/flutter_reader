class User {
  String access_token;
  int expire_in;
  String lastname;
  String firstname;

  User.fromJsonMap(Map<String, dynamic> map)
      : access_token = map["access_token"],
        expire_in = map["expire_in"],
        lastname = map["lastname"],
        firstname = map["firstname"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = access_token;
    data['expire_in'] = expire_in;
    data['lastname'] = lastname;
    data['firstname'] = firstname;
    return data;
  }
}
