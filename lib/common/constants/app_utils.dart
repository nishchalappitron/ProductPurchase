import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:interview_testing/data/model/data_listing.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppUtils {
  Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('user_logged_in') ?? false;
    return isLoggedIn;
  }

  void setUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', true);
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', false);
    prefs.clear();
  }

  void setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', userName);
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_name') ?? "";
    return userName;
  }

  void setUserEmail(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', userName);
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_email') ?? "";
    return userName;
  }

  void setCartList(List<String> cartList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cart_list', cartList);
  }

  Future<List<CategoryDish>> getCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList('cart_list') ?? [];
    return cartList.map((player) => CategoryDish.fromJson(jsonDecode(player))).toList();
  }

}
