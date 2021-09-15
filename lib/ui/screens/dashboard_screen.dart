import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_testing/blocs/auth/cart_list_bloc.dart';
import 'package:interview_testing/blocs/auth/category_data_bloc.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/common/router/router.gr.dart';
import 'package:interview_testing/common/service/navigation_service.dart';
import 'package:interview_testing/ui/screens/drawer.dart';
import 'package:interview_testing/ui/screens/category_dishes_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartListBloc>(context).add(CartListRefreshEvent(isFetchFromSp: true));
    BlocProvider.of<CategoryDataBloc>(context).add(CategoryDataRefreshEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDataBloc, CategoryDataState>(
      builder: (context, state) {
        if(state is CategoryDataLoadingState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,

              leading: Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.menu_outlined),
                    color: Colors.black,
                    onPressed: () => Scaffold.of(context).openDrawer()),
              ),

              actions: [
                IconButton(
                    onPressed: (){
                      locator<NavigationService>().push(OrderSummaryRoute());
                    },
                    color: Colors.black54,
                    icon: Icon(Icons.shopping_cart)
                )
              ],
            ),

            drawer: DrawerScreen(),

            body: Center(
              child: CircularProgressIndicator(),
            ),

          );
        } else if(state is CategoryDataSuccessState) {
          return DefaultTabController(
              length: (state.dataList.table_menu_list??[]).length,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,

                  leading: Builder(
                    builder: (context) => // Ensure Scaffold is in context
                    IconButton(
                        icon: Icon(Icons.menu_outlined),
                        color: Colors.black,
                        onPressed: () => Scaffold.of(context).openDrawer()),
                  ),

                  actions: [
                    IconButton(
                        onPressed: (){
                          locator<NavigationService>().push(OrderSummaryRoute());

                        },
                        color: Colors.black54,
                        icon: Icon(Icons.shopping_cart)
                    )
                  ],

                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: TabBar(
                        indicatorColor: Colors.red,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.red,
                        isScrollable: true,
                        tabs: (state.dataList.table_menu_list??[]).map((val) {
                          return Tab(text: val.menu_category);
                        },
                        ).toList(),
                    ),
                  ),
                ),

                drawer: DrawerScreen(),

                body: BlocBuilder<CartListBloc, CartListState>(
                  builder: (context, cartState) {
                    if(cartState is CartListLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if(cartState is CartListSuccessState) {
                      return TabBarView(
                          children: (state.dataList.table_menu_list??[]).map((val) {
                            return CategoryDishesScreen(val.category_dishes??[], cartState.cartList);
                          }).toList()
                      );
                    } else if(cartState is CartListErrorState) {
                      return TabBarView(
                          children: (state.dataList.table_menu_list??[]).map((val) {
                            return CategoryDishesScreen(val.category_dishes??[], []);
                          }).toList()
                      );
                    } return Container();
                  },
                ),

              )
          );
        } else if(state is CategoryDataErrorState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,

              leading: Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.menu_outlined),
                    color: Colors.black,
                    onPressed: () => Scaffold.of(context).openDrawer()),
              ),

              actions: [
                IconButton(
                    onPressed: (){
                      locator<NavigationService>().push(OrderSummaryRoute());
                    },
                    color: Colors.black54,
                    icon: Icon(Icons.shopping_cart)
                )
              ],
            ),

            drawer: DrawerScreen(),

            body: Center(
              child: CircularProgressIndicator(),
            ),

          );
        }
        return Container();
      },
    );
  }
}