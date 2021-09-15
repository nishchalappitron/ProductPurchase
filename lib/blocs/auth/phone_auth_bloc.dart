import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_testing/common/constants/app_utils.dart';

class PhoneSignInEvent {}

class PhoneSignInRefreshEvent extends PhoneSignInEvent {
  String? number;
  PhoneSignInRefreshEvent(this.number);
}

class PhoneVerifyRefreshEvent extends PhoneSignInEvent {
  String phone;
  String verificationId;
  String smsCode;
  PhoneVerifyRefreshEvent(this.phone, this.verificationId, this.smsCode);
}

class PhoneSignInState {}

class PhoneSignInInitialState extends PhoneSignInState {}

class PhoneSignInLoadingState extends PhoneSignInState {}

class PhoneSignInSuccessState extends PhoneSignInState {
  String verificationId;
  PhoneSignInSuccessState(this.verificationId);
}

class PhoneSignInSuccessOtpState extends PhoneSignInState {}

class PhoneSignInErrorState extends PhoneSignInState {
  String errorMessage;
  PhoneSignInErrorState(this.errorMessage);
}

class PhoneSignInBloc extends Bloc<PhoneSignInEvent, PhoneSignInState> {
  AppUtils appUtils;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  PhoneSignInBloc(this.appUtils) : super(PhoneSignInInitialState());

  @override
  Stream<PhoneSignInState> mapEventToState(PhoneSignInEvent event) async* {
    try {
      if(event is PhoneSignInRefreshEvent) {

        yield PhoneSignInLoadingState();
        await _auth.verifyPhoneNumber(
            phoneNumber: "+91${event.number}",
            verificationCompleted: (PhoneAuthCredential authCredential) async* {
              print('njfndknfknfg');

            },
            verificationFailed: (FirebaseAuthException exception) async*  {
              if (exception.code == 'invalid-phone-number') {
                yield PhoneSignInErrorState("The phone number entered is invalid!");
              }
            },
            codeSent: (String verificationId, int? forceResendingToken) async* {
              yield PhoneSignInSuccessState(verificationId);
            },
            codeAutoRetrievalTimeout: (String timeout) async* {
              yield PhoneSignInErrorState(timeout);
            });
      }

      if(event is PhoneVerifyRefreshEvent) {
        yield PhoneSignInLoadingState();
        AuthCredential credential = PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.smsCode);

        UserCredential result = await _auth.signInWithCredential(credential);

        User? user = result.user;

        if(user != null){
          appUtils.setUserEmail(event.phone);
          yield PhoneSignInSuccessOtpState();
        }else{
          yield PhoneSignInErrorState('Something went wrong, try again');
        }
      }

    } catch(e, stacktrace) {
      print("$e : $stacktrace");
      yield PhoneSignInErrorState(e.toString());
    }
  }

}