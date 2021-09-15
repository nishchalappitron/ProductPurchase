import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview_testing/blocs/auth/google_signin_bloc.dart';
import 'package:interview_testing/common/constants/assets.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/common/router/router.gr.dart';
import 'package:interview_testing/common/service/dialog_service.dart';
import 'package:interview_testing/common/service/navigation_service.dart';
import 'package:interview_testing/common/service/toast_service.dart';
import 'package:interview_testing/ui/screens/phone_auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icFirebase, height: 150, width: 150,),

            SizedBox(height: 0.2.sh),

            BlocListener<GoogleSignInBloc, GoogleSignInState>(
              listener: (context, state) {
                if(state is GoogleSignInLoadingState) {
                  locator<DialogService>().showLoader();
                } else if(state is GoogleSignInSuccessState) {
                  locator<DialogService>().hideLoader();
                  locator<NavigationService>().pushAndRemoveUntil(DashBoardScreenRoute());
                } else if(state is GoogleSignInErrorState) {
                  locator<DialogService>().hideLoader();
                  locator<ToastService>().show(state.errorMessage);
                }
              },
              child: InkWell(
                onTap: (){
                  BlocProvider.of<GoogleSignInBloc>(context).add(GoogleSignInRefreshEvent());
                },
                child: button(Colors.blue, "Google", Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(icGoogle)
                      )
                  ),
                ),),
              ),
            ),

            SizedBox(height: 10.h),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuthScreen()));
              },
              child: button(Colors.green, "Phone", Icon(Icons.call, size: 30, color: Colors.grey[200],),)
            ),
          ],
        ),
      ),
    );
  }

  Widget button(Color color, String text, Widget widget){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget,

          Text(text, textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),

          Container(height: 30, width: 30)
        ],
      ),
    );
  }

}
