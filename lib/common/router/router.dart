import 'package:auto_route/auto_route.dart';
import 'package:interview_testing/ui/screens/dashboard_screen.dart';
import 'package:interview_testing/ui/screens/login_screen.dart';
import 'package:interview_testing/ui/screens/order_summary.dart';
import 'package:interview_testing/ui/screens/splash_screen.dart';

@MaterialAutoRouter(
    routes: (
      <AutoRoute>[
        MaterialRoute(page: SplashScreen, initial: true),
        MaterialRoute(page: LoginScreen),
        MaterialRoute(page: DashBoardScreen),
        MaterialRoute(page: OrderSummary),
      ]
    )
)
class $AppRouter {}
