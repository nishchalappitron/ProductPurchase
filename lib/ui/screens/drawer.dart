import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_testing/blocs/auth/google_signin_bloc.dart';
import 'package:interview_testing/common/constants/app_utils.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/common/service/dialog_service.dart';
import 'package:interview_testing/common/service/navigation_service.dart';
import 'package:interview_testing/common/service/toast_service.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String userEmail="";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  getUserName() async {
     userEmail = await AppUtils().getUserEmail();
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: height*0.08, bottom: height*0.03, left: 20, right: 20),
            height: height*0.28,
            width: width*0.9,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpfEoLgUZb8rQY3QwKyfQbBzta_UNIN7ZIDmAoNGHiWO_VVD9iGrEddfp7C4g5BsebfRY&usqp=CAU"),
                ),
                SizedBox(height: 10),
                userEmail == null || userEmail.isEmpty ? Container() : Expanded(child: Text(userEmail, style: TextStyle(color: Colors.white), textScaleFactor: 1.2)),
                // SizedBox(height: 5),
              ],
            ),
          ),

          BlocListener<GoogleSignInBloc, GoogleSignInState>(
            listener: (context, state) {
              if(state is GoogleSignInLoadingState) {
                locator<DialogService>().showLoader();
              } else if(state is GoogleLogOutSuccessState) {
                locator<DialogService>().hideLoader();
                locator<NavigationService>().logout(userConfirmationRequired: true);
              } else if(state is GoogleSignInErrorState) {
                locator<DialogService>().hideLoader();
                locator<ToastService>().show(state.errorMessage);
              }
            },
            child: ListTile(
              leading: Icon(Icons.logout, size: 25),
              title: Text("Log out", style: TextStyle(color: Colors.grey), textScaleFactor: 1.1,),
              onTap: (){
                BlocProvider.of<GoogleSignInBloc>(context).add(GoogleLogOutRefreshEvent());
              },
            ),
          ),

        ],
      ),
    );
  }
}
