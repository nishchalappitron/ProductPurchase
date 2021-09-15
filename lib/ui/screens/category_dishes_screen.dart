import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_testing/blocs/auth/cart_list_bloc.dart';
import 'package:interview_testing/data/model/data_listing.dart';

class CategoryDishesScreen extends StatefulWidget {
  List<CategoryDish> categoryData;
  List<CategoryDish> cartList;
  CategoryDishesScreen(this.categoryData, this.cartList);

  @override
  _CategoryDishesScreenState createState() => _CategoryDishesScreenState();
}

class _CategoryDishesScreenState extends State<CategoryDishesScreen> {

  @override
  Widget build(BuildContext context) {
    return widget.categoryData.length > 0 ? ListView.separated(
      itemCount: widget.categoryData.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index){
        List<CategoryDish> cartSelected = widget.cartList.where((element) => (element.dish_id??"")==(widget.categoryData[index].dish_id??"")).toList();
        if(cartSelected.length > 0)
          widget.categoryData[index].quantity = cartSelected[0].quantity;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.green
                    )
                ),
                child: Icon(Icons.circle, color: Colors.green, size: 15),
              ),

              SizedBox(width: 5),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.categoryData[index].dish_name??"", textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.categoryData[index].dish_currency} ${widget.categoryData[index].dish_price}", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),

                        Text("${widget.categoryData[index].dish_calories} calories", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(widget.categoryData[index].dish_description??"", textScaleFactor: 1.1, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 10),
                    (widget.categoryData[index].dish_Availability??false) ? Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                                  onTap: (){
                                    if((widget.categoryData[index].quantity??0).toInt() > 0){
                                      setState(() {
                                        widget.categoryData[index].quantity = (widget.categoryData[index].quantity??0).toInt() - 1;
                                      });
                                      BlocProvider.of<CartListBloc>(context).add(CartListRefreshEvent(isNewData: true, categoryDish: widget.categoryData[index]));
                                    }
                                  },
                                  child: Icon(Icons.remove, color: Colors.white,)
                              )
                          ),
                          Expanded(
                              child: Center(child: Text((widget.categoryData[index].quantity??0).toString(), textScaleFactor: 1.2, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),))
                          ),
                          Expanded(
                              child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      widget.categoryData[index].quantity = (widget.categoryData[index].quantity??0).toInt() + 1;
                                    });
                                    BlocProvider.of<CartListBloc>(context).add(CartListRefreshEvent(isNewData: true, categoryDish: widget.categoryData[index]));

                                  },
                                  child: Icon(Icons.add, color: Colors.white,)
                              )
                          )
                        ],
                      ),
                    ) : Container(),
                  ],
                ),
              ),

              SizedBox(width: 5),

              Container(
                height: 80,
                width: 60,
                child: CachedNetworkImage(
                  imageUrl: widget.categoryData[index].dish_image??"",
                  fit: BoxFit.fill,
                  placeholder: (context, data) {
                    return Icon(Icons.photo, size: 80, color: Colors.grey,);
                  },
                  errorWidget: (context, data, d) {
                    return Icon(Icons.photo, size: 80, color: Colors.grey,);
                  },
                ),
              )
            ],
          ),
        );
      },
    ) : Center(
      child: Text("Currently no items found for this category"),
    );
  }
}

