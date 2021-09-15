import 'package:firebase_core/firebase_core.dart';
import 'package:interview_testing/blocs/auth/cart_list_bloc.dart';
import 'package:interview_testing/blocs/auth/category_data_bloc.dart';
import 'package:interview_testing/blocs/auth/google_signin_bloc.dart';
import 'package:interview_testing/common/constants/app_utils.dart';
import 'package:interview_testing/common/constants/colors.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview_testing/common/router/router.gr.dart';
import 'package:interview_testing/data/repository/user_repository.dart';

import 'blocs/auth/phone_auth_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppUtils _appUtils = locator<AppUtils>();
  final DataRepository _dataRepository = locator<DataRepository>();
  AppUtils? appUtils;
  bool isLogIn = false;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  getDetail() async {
    await appUtils?.getUserLoggedIn().then((value) {
      isLogIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          // Login
          BlocProvider<CategoryDataBloc>(
            create: (context) => CategoryDataBloc(_dataRepository, _appUtils),
          ),
          BlocProvider<CartListBloc>(
            create: (context) => CartListBloc(_appUtils),
          ),
          BlocProvider<GoogleSignInBloc>(
            create: (context) => GoogleSignInBloc(_appUtils),
          ),
          BlocProvider<PhoneSignInBloc>(
            create: (context) => PhoneSignInBloc(_appUtils),
          ),
        ],
        child: ScreenUtilInit(
          designSize: Size(360, 690),
          builder: () => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                accentColor: colorPrimary,
                bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
                scaffoldBackgroundColor: bgPage,
                primaryColor: colorPrimary,
              ),
              routerDelegate: locator<AppRouter>().delegate(),
              routeInformationParser: locator<AppRouter>().defaultRouteParser()),
        )
    );
  }

}
