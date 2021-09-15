import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:interview_testing/blocs/auth/phone_auth_bloc.dart';
import 'package:interview_testing/common/constants/alert_message.dart';
import 'package:interview_testing/common/constants/assets.dart';
import 'package:interview_testing/common/constants/colors.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/common/router/router.gr.dart';
import 'package:interview_testing/common/service/dialog_service.dart';
import 'package:interview_testing/common/service/navigation_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview_testing/common/service/toast_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icFirebase, height: 150, width: 150,),

                SizedBox(height: 0.2.sh),

                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Enter Phone",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        border: OutlineInputBorder(borderSide: BorderSide(color: colorPrimary, width: 3.0),
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
                SizedBox(height: size.height * 0.05,),

                BlocListener<PhoneSignInBloc, PhoneSignInState>(
                  listener: (con, state) {
                    if(state is PhoneSignInLoadingState) {
                      locator<DialogService>().showLoader();
                    } else if(state is PhoneSignInSuccessState) {
                      locator<DialogService>().hideLoader();
                      showOTPDialog(context, state.verificationId);
                    }  else if(state is PhoneSignInSuccessOtpState) {

                      locator<DialogService>().hideLoader();
                      locator<NavigationService>().pushAndRemoveUntil(DashBoardScreenRoute());
                    } else if(state is PhoneSignInErrorState) {
                      locator<DialogService>().hideLoader();
                      locator<ToastService>().show(state.errorMessage);
                    }
                  },
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: OutlinedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          locator<DialogService>().showLoader();
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          await _auth.verifyPhoneNumber(
                              phoneNumber: "+91${phoneController.text.trim()}",
                              verificationCompleted: (PhoneAuthCredential authCredential) {},
                              verificationFailed: (FirebaseAuthException exception) {
                                locator<ToastService>().show(exception.message??AlertMessages.GENERIC_ERROR_MSG);
                              },
                              codeSent: (String verificationId, int? forceResendingToken) {
                                locator<DialogService>().hideLoader();
                                showOTPDialog(context, verificationId);
                              },
                              codeAutoRetrievalTimeout: (String timeout) async* {
                                locator<ToastService>().show(timeout);
                              });
                        }
                      },
                      child: Text("SignIn", style: TextStyle(color: Colors.white),),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: colorPrimary)),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                          backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
                          side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ));
  }

  showOTPDialog(BuildContext context, String verificationId) {
    TextEditingController otpController = TextEditingController();
    print("code sent");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Please Enter OTP"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: otpController,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: Text("Submit"),
                textColor: Colors.white,
                color: colorPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                onPressed: () {
                  if(otpController.text.isNotEmpty){
                    locator<NavigationService>().pop();
                    BlocProvider.of<PhoneSignInBloc>(context).add(PhoneVerifyRefreshEvent("+91${phoneController.text.trim()}", verificationId, otpController.text));
                  } else{
                    Fluttertoast.showToast(msg: 'Please Enter OTP');
                  }
                },
              )
            ],
          );
        }
    );
  }

}
