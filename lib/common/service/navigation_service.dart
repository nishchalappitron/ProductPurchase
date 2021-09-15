import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_testing/common/constants/app_utils.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/common/router/router.gr.dart';
import 'package:interview_testing/common/service/dialog_service.dart';

@lazySingleton
class NavigationService {
  final AppRouter _router;

  NavigationService(this._router);

  Future push<T>(PageRouteInfo routeInfo) async {
    try {
      return await _router.push(routeInfo);
    } on Exception catch (e) {
      print('Exception occurred in push: $e');
    }
  }

  Future popAndPush(PageRouteInfo routeInfo) async {
    try {
      return _router.popAndPush(routeInfo);
    } on Exception catch (e) {
      print('Exception occurred in popAndPush: $e');
    }
  }

  Future pushAndRemoveUntil(PageRouteInfo routeInfo) async {
    try {
      return await _router.pushAndPopUntil(routeInfo, predicate: (route) => false);
    } on Exception catch (e) {
      print('Exception occurred in pushAndRemoveUntil: $e');
    }
  }

  Future pushAndRemoveUntilPage(PageRouteInfo routeInfo, String pageTillRemove) async {
    try {
      await _router.removeUntil((route) => route.name == pageTillRemove);
      return push(routeInfo);
    } on Exception catch (e) {
      print('Exception occurred in pushAndRemoveUntil: $e');
    }
  }

  Future<bool> pop<T extends Object>([T? result]) async {
    try {
      return await _router.pop(result);
    } on Exception catch (e) {
      print('Exception occurred in pop: $e');
      return Future.value(false);
    }
  }

  void popToRoot() {
    try {
      return _router.popUntil((route) => route.isFirst);
    } on Exception catch (e) {
      print('Exception occurred in popToRoot: $e');
    }
  }

  /*Future<void> gotoHome({bool refresh = false, BuildContext? context}) async {
    _router.removeUntil((route) => route.name == DashboardScreenRoute.name);
  }*/

  Future<void> logout({bool userConfirmationRequired = false}) async {
    if (userConfirmationRequired) {
      await locator<DialogService>().confirm(
          title: "Logout",
          message: "Are you sure you want to logout from the app?",
          onPositiveBtnPressed: () async => await clearSessionAndLogout());
    } else {
      await clearSessionAndLogout();
    }
  }

  Future<void> clearSessionAndLogout() async {
    locator<AppUtils>().logoutUser();
    await pushAndRemoveUntil(LoginScreenRoute());
  }

}
