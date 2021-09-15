import 'package:json_annotation/json_annotation.dart';

part 'data_listing.g.dart';

@JsonSerializable()
class DataItem {
  String restaurant_id;
  String? restaurant_name;
  String? restaurant_image;
  String? table_id;
  String? table_name;
  String? branch_name;
  String? nexturl;
  List<TableCategoryItem>? table_menu_list;

  DataItem({required this.restaurant_id, this.restaurant_name, this.restaurant_image, this.table_id, this.table_name, this.branch_name, this.nexturl, this.table_menu_list});

  factory DataItem.fromJson(Map<String, dynamic> json) => _$DataItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataItemToJson(this);
}

@JsonSerializable()
class TableCategoryItem {
  String? menu_category;
  String menu_category_id;
  String? menu_category_image;
  String? nexturl;
  List<CategoryDish>? category_dishes;

  TableCategoryItem({this.menu_category, required this.menu_category_id, this.menu_category_image, this.nexturl, this.category_dishes});

  factory TableCategoryItem.fromJson(Map<String, dynamic> json) => _$TableCategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$TableCategoryItemToJson(this);
}

@JsonSerializable()
class CategoryDish {
  String? dish_id;
  String? dish_name;
  num? dish_price;
  String? dish_image;
  String? dish_currency;
  num? dish_calories;
  String? dish_description;
  bool? dish_Availability;
  num? dish_Type;
  String? nexturl;
  List<AddonCatBean>? addonCat;
  int? quantity;

  CategoryDish({this.dish_id, this.dish_name, this.dish_price, this.dish_image, this.dish_currency, this.dish_calories, this.dish_description, this.dish_Availability, this.dish_Type, this.nexturl, this.addonCat, this.quantity=0});

  factory CategoryDish.fromJson(Map<String, dynamic> json) => _$CategoryDishFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDishToJson(this);
}

@JsonSerializable()
class AddonCatBean {
  String? addon_category;
  String addon_category_id;
  num? addon_selection;
  String? nexturl;
  List<AddonsBean>? addons;

  AddonCatBean({this.addon_category, required this.addon_category_id, this.addon_selection, this.nexturl, this.addons});

  factory AddonCatBean.fromJson(Map<String, dynamic> json) => _$AddonCatBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AddonCatBeanToJson(this);
}

@JsonSerializable()
class AddonsBean {
  String dish_id;
  String? dish_name;
  num? dish_price;
  String? dish_image;
  String? dish_currency;
  num? dish_calories;
  String? dish_description;
  bool? dish_Availability;
  num? dish_Type;

  AddonsBean({required this.dish_id, this.dish_name, this.dish_price, this.dish_image, this.dish_currency, this.dish_calories, this.dish_description, this.dish_Availability, this.dish_Type});

  factory AddonsBean.fromJson(Map<String, dynamic> json) => _$AddonsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AddonsBeanToJson(this);
}

