import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_testing/blocs/auth/cart_list_bloc.dart';
import 'package:interview_testing/common/constants/colors.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/common/service/dialog_service.dart';
import 'package:interview_testing/common/service/navigation_service.dart';
import 'package:interview_testing/data/model/data_listing.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.grey
        ),

        title: Text("Order Summary", style: TextStyle(color: Colors.grey),),
      ),

      body: BlocBuilder<CartListBloc, CartListState>(
        builder: (context, state) {
          if(state is CartListLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is CartListSuccessState) {
            return Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    /*offset: const Offset(
                5.0,
                5.0,
              ),*/
                    spreadRadius: 1.0,
                    blurRadius: 3.0,
                  ),//BoxShadow
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text("${state.cartList.length} Dishes - ${state.totalItems} Items", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                    ),

                    ListView.separated(
                        itemCount: state.cartList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(color: Colors.grey),
                        itemBuilder: (context, index){
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: colorPrimary
                                      )
                                  ),
                                  child: Icon(Icons.circle, color: colorPrimary, size: 15),
                                ),

                                SizedBox(width: 5),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(state.cartList[index].dish_name??"", textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      Text("${state.cartList[index].dish_currency??""} ${state.cartList[index].dish_price??""}", textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text("${state.cartList[index].dish_calories??""} calories", textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 5),

                                Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                              onTap: (){
                                                if((state.cartList[index].quantity??0).toInt() > 0){
                                                  setState(() {
                                                    state.cartList[index].quantity = (state.cartList[index].quantity??0).toInt() - 1;
                                                  });
                                                  BlocProvider.of<CartListBloc>(context).add(CartListRefreshEvent(isNewData: true, categoryDish: state.cartList[index]));
                                                }
                                              },
                                              child: Icon(Icons.remove, color: Colors.white)
                                          )
                                      ),
                                      Expanded(
                                          child: Center(child: Text((state.cartList[index].quantity??0).toString(), textScaleFactor: 1.2, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),))
                                      ),
                                      Expanded(
                                          child: InkWell(
                                              onTap: (){
                                                setState(() {
                                                  state.cartList[index].quantity = (state.cartList[index].quantity??0).toInt() + 1;
                                                });
                                                BlocProvider.of<CartListBloc>(context).add(CartListRefreshEvent(isNewData: true, categoryDish: state.cartList[index]));

                                              },
                                              child: Icon(Icons.add, color: Colors.white)
                                          )
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(width: 5),

                                Text("${state.cartList[index].dish_currency??""} ${state.cartList[index].dish_price??""}", textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        }
                    ),

                    Divider(color: Colors.grey[200], thickness: 3),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Amount", textScaleFactor: 1.4, style: TextStyle(fontWeight: FontWeight.bold),),

                          Text("SAR ${state.totalPrice}", textScaleFactor: 1.3, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),

                    SizedBox(height: 60)
                  ],
                ),
              ),
            );
          } else if(state is CartListErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } return Container();
        },
      ),

      bottomSheet: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
            ),
            onPressed: (){
              locator<DialogService>().show(
                  title: "Order Placed",
                  message: "You Order is Successfully Placed.",
                  isDismissible: true,
                  okLabel: "OK",
                  onOkBtnPressed: () {
                    locator<NavigationService>().pop();
                  }
              );
            },
            child: Text("Place Order", style: TextStyle(color: Colors.white), textScaleFactor: 1.2,)
        ),
      ),
    );
  }
}

