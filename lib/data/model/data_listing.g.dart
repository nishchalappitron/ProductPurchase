// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataItem _$DataItemFromJson(Map<String, dynamic> json) {
  return DataItem(
    restaurant_id: json['restaurant_id'] as String,
    restaurant_name: json['restaurant_name'] as String?,
    restaurant_image: json['restaurant_image'] as String?,
    table_id: json['table_id'] as String?,
    table_name: json['table_name'] as String?,
    branch_name: json['branch_name'] as String?,
    nexturl: json['nexturl'] as String?,
    table_menu_list: (json['table_menu_list'] as List<dynamic>?)
        ?.map((e) => TableCategoryItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DataItemToJson(DataItem instance) => <String, dynamic>{
      'restaurant_id': instance.restaurant_id,
      'restaurant_name': instance.restaurant_name,
      'restaurant_image': instance.restaurant_image,
      'table_id': instance.table_id,
      'table_name': instance.table_name,
      'branch_name': instance.branch_name,
      'nexturl': instance.nexturl,
      'table_menu_list': instance.table_menu_list,
    };

TableCategoryItem _$TableCategoryItemFromJson(Map<String, dynamic> json) {
  return TableCategoryItem(
    menu_category: json['menu_category'] as String?,
    menu_category_id: json['menu_category_id'] as String,
    menu_category_image: json['menu_category_image'] as String?,
    nexturl: json['nexturl'] as String?,
    category_dishes: (json['category_dishes'] as List<dynamic>?)
        ?.map((e) => CategoryDish.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TableCategoryItemToJson(TableCategoryItem instance) =>
    <String, dynamic>{
      'menu_category': instance.menu_category,
      'menu_category_id': instance.menu_category_id,
      'menu_category_image': instance.menu_category_image,
      'nexturl': instance.nexturl,
      'category_dishes': instance.category_dishes,
    };

CategoryDish _$CategoryDishFromJson(Map<String, dynamic> json) {
  return CategoryDish(
    dish_id: json['dish_id'] as String?,
    dish_name: json['dish_name'] as String?,
    dish_price: json['dish_price'] as num?,
    dish_image: json['dish_image'] as String?,
    dish_currency: json['dish_currency'] as String?,
    dish_calories: json['dish_calories'] as num?,
    dish_description: json['dish_description'] as String?,
    dish_Availability: json['dish_Availability'] as bool?,
    dish_Type: json['dish_Type'] as num?,
    nexturl: json['nexturl'] as String?,
    addonCat: (json['addonCat'] as List<dynamic>?)
        ?.map((e) => AddonCatBean.fromJson(e as Map<String, dynamic>))
        .toList(),
    quantity: json['quantity'] as int?,
  );
}

Map<String, dynamic> _$CategoryDishToJson(CategoryDish instance) =>
    <String, dynamic>{
      'dish_id': instance.dish_id,
      'dish_name': instance.dish_name,
      'dish_price': instance.dish_price,
      'dish_image': instance.dish_image,
      'dish_currency': instance.dish_currency,
      'dish_calories': instance.dish_calories,
      'dish_description': instance.dish_description,
      'dish_Availability': instance.dish_Availability,
      'dish_Type': instance.dish_Type,
      'nexturl': instance.nexturl,
      'addonCat': instance.addonCat,
      'quantity': instance.quantity,
    };

AddonCatBean _$AddonCatBeanFromJson(Map<String, dynamic> json) {
  return AddonCatBean(
    addon_category: json['addon_category'] as String?,
    addon_category_id: json['addon_category_id'] as String,
    addon_selection: json['addon_selection'] as num?,
    nexturl: json['nexturl'] as String?,
    addons: (json['addons'] as List<dynamic>?)
        ?.map((e) => AddonsBean.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AddonCatBeanToJson(AddonCatBean instance) =>
    <String, dynamic>{
      'addon_category': instance.addon_category,
      'addon_category_id': instance.addon_category_id,
      'addon_selection': instance.addon_selection,
      'nexturl': instance.nexturl,
      'addons': instance.addons,
    };

AddonsBean _$AddonsBeanFromJson(Map<String, dynamic> json) {
  return AddonsBean(
    dish_id: json['dish_id'] as String,
    dish_name: json['dish_name'] as String?,
    dish_price: json['dish_price'] as num?,
    dish_image: json['dish_image'] as String?,
    dish_currency: json['dish_currency'] as String?,
    dish_calories: json['dish_calories'] as num?,
    dish_description: json['dish_description'] as String?,
    dish_Availability: json['dish_Availability'] as bool?,
    dish_Type: json['dish_Type'] as num?,
  );
}

Map<String, dynamic> _$AddonsBeanToJson(AddonsBean instance) =>
    <String, dynamic>{
      'dish_id': instance.dish_id,
      'dish_name': instance.dish_name,
      'dish_price': instance.dish_price,
      'dish_image': instance.dish_image,
      'dish_currency': instance.dish_currency,
      'dish_calories': instance.dish_calories,
      'dish_description': instance.dish_description,
      'dish_Availability': instance.dish_Availability,
      'dish_Type': instance.dish_Type,
    };
