import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_testing/common/constants/alert_message.dart';
import 'package:interview_testing/common/constants/app_utils.dart';

class GoogleSignInEvent {}

class GoogleSignInRefreshEvent extends GoogleSignInEvent {}

class GoogleLogOutRefreshEvent extends GoogleSignInEvent {}

class GoogleSignInState {}

class GoogleSignInInitialState extends GoogleSignInState {}

class GoogleSignInLoadingState extends GoogleSignInState {}

class GoogleSignInSuccessState extends GoogleSignInState {}

class GoogleLogOutSuccessState extends GoogleSignInState {}

class GoogleSignInErrorState extends GoogleSignInState {
  String errorMessage;
  GoogleSignInErrorState(this.errorMessage);
}

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  AppUtils appUtils;

  bool isLogin =false;
  final googleSignIn = GoogleSignIn();
  String userEmail="";
  UserCredential? response;

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user =>_user!;

  GoogleSignInBloc(this.appUtils) : super(GoogleSignInInitialState());

  @override
  Stream<GoogleSignInState> mapEventToState(GoogleSignInEvent event) async* {
    try {
      if(event is GoogleSignInRefreshEvent) {
        final googleUser = await googleSignIn.signIn();
        if(googleUser == null )
          yield GoogleSignInErrorState(AlertMessages.GENERIC_ERROR_MSG);
        _user = googleUser;
        final googleAuth =await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken
        );

        response = await FirebaseAuth.instance.signInWithCredential(credential);
        print("googleData");
        print(response);
        if(response!.user != null){
          userEmail=response!.user!.email.toString();
          appUtils.setUserEmail(response!.user!.email.toString());
          appUtils.setUserLoggedIn();
          await googleSignIn.disconnect();
          FirebaseAuth.instance.signOut();
          yield GoogleSignInSuccessState();
        }
        else{
          yield GoogleSignInErrorState('User not found, try again');
        }
      }

      if(event is GoogleLogOutRefreshEvent) {
        appUtils.logoutUser();
        FirebaseAuth.instance.signOut();
        yield GoogleLogOutSuccessState();
      }

    } catch(e, stacktrace) {
      print("$e : $stacktrace");
      yield GoogleSignInErrorState(e.toString());
    }
  }

}