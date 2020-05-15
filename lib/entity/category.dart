import 'base.dart';

class Category extends Base {
  List<CategoryList> male;
  List<CategoryList> female;
  List<CategoryList> picture;
  List<CategoryList> press;

  static Category fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Category category = Category();
    category.male = List()
      ..addAll((map['male'] as List ?? []).map((o) => CategoryList.fromMap(o)));
    category.female = List()
      ..addAll(
          (map['female'] as List ?? []).map((o) => CategoryList.fromMap(o)));
    category.picture = List()
      ..addAll(
          (map['picture'] as List ?? []).map((o) => CategoryList.fromMap(o)));
    category.press = List()
      ..addAll(
          (map['press'] as List ?? []).map((o) => CategoryList.fromMap(o)));

    return category;
  }
}

class CategoryList {
  String name;
  int bookCount;
  int monthlyCount;
  String icon;
  List<String> bookCover;

  static CategoryList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoryList categoryList = CategoryList();
    categoryList.name = map['name'];
    categoryList.bookCount = map['bookCount'];
    categoryList.monthlyCount = map['monthlyCount'];
    categoryList.icon = map['icon'];
    categoryList.bookCover = map['bookCover'].cast<String>();
    return categoryList;
  }

  Map toJson() => {
        "name": name,
        "bookCount": bookCount,
        "monthlyCount": monthlyCount,
        "icon": icon,
        "bookCover": bookCover,
      };
}
