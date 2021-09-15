import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_testing/common/constants/app_utils.dart';
import 'package:interview_testing/data/model/data_listing.dart';

class CartListEvent {}

class CartListRefreshEvent extends CartListEvent {
  bool isNewData;
  bool isFetchFromSp;
  CategoryDish? categoryDish;

  CartListRefreshEvent({this.isNewData=false, this.isFetchFromSp=false, this.categoryDish});
}

class CartListState {}

class CartListInitialState extends CartListState {}

class CartListLoadingState extends CartListState {}

class CartListSuccessState extends CartListState {
  List<CategoryDish> cartList;
  int totalItems;
  double totalPrice;
  CartListSuccessState(this.cartList, this.totalItems, this.totalPrice);
}

class CartListErrorState extends CartListState {
  String errorMessage;
  CartListErrorState(this.errorMessage);
}

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  AppUtils _appUtils;

  final blocController = StreamController.broadcast();
  Stream get getStream => blocController.stream;
  List<CategoryDish> cartList = <CategoryDish>[];

  CartListBloc(this._appUtils) : super(CartListInitialState());

  @override
  Stream<CartListState> mapEventToState(CartListEvent event) async* {
    if(event is CartListRefreshEvent) {
      if(event.isNewData && event.categoryDish!=null) {
        int index = cartList.indexWhere((element) => element.dish_id==event.categoryDish?.dish_id);
        if (index == -1) {
          cartList.add(event.categoryDish!);
        } else {
          if((event.categoryDish?.quantity??0) > 0) {
            cartList[index] = event.categoryDish!;
          } else {
            cartList.removeAt(index);
          }
        }
        blocController.sink.add(cartList);
        _appUtils.setCartList(cartList.map((item) => jsonEncode(item.toJson())).toList());
        int count = 0;
        double price = 0;
        cartList.forEach((element) {
          count = count + (element.quantity??0).toInt();
          price = price + ((element.dish_price??0).toDouble() * (element.quantity??0).toInt());
        });
        yield CartListSuccessState(cartList, count, price);
      } else {
        if(event.isFetchFromSp) {
          yield CartListLoadingState();
          await _appUtils.getCartList().then((value) {
            if(value.length > 0) {
              cartList.addAll(value);
              blocController.sink.add(cartList);
            }
          });
          int count = 0;
          double price = 0;
          cartList.forEach((element) {
            count = count + (element.quantity??0).toInt();
            price = price + ((element.dish_price??0).toDouble() * (element.quantity??0).toInt());
          });
          yield CartListSuccessState(cartList, count, price);
        } else {
          int count = 0;
          double price = 0;
          cartList.forEach((element) {
            count = count + (element.quantity??0).toInt();
            price = price + ((element.dish_price??0).toDouble() * (element.quantity??0).toInt());
          });
          yield CartListSuccessState(cartList, count, price);
        }

      }

    }
  }

}