import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_testing/common/router/router.gr.dart';
import 'package:interview_testing/ui/widgets/app_progress_indicator.dart';
import 'package:ndialog/ndialog.dart';

@lazySingleton
class DialogService {
  final AppRouter _router;

  DialogService(this._router);

  ProgressDialog? _pr;
  CustomProgressDialog? _cpr;

  BuildContext _getSafeContext() {
    final context = _router.navigatorKey.currentContext;
    return context != null
        ? context
        : throw ('Have you forgot to setup routes?');
  }

  Future<void> show(
      {String? title,
      String? message,
      String? okLabel,
      bool isDismissible = true,
      VoidCallback? onOkBtnPressed}) async {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      return await showOkAlertDialog(
              context: _getSafeContext(),
              title: title,
              message: message,
              okLabel: okLabel,
              barrierDismissible: isDismissible)
          .then((value) {
        if (value == OkCancelResult.ok) onOkBtnPressed?.call();
      });
    });
  }

  Future<void> confirm(
      {String? title,
      String? message,
      String okButton = 'Yes',
      String cancelButton = 'No',
      VoidCallback? onPositiveBtnPressed,
      VoidCallback? onNegativeBtnPressed}) async {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      return await showOkCancelAlertDialog(
              context: _getSafeContext(),
              title: title,
              message: message,
              okLabel: okButton,
              cancelLabel: cancelButton)
          .then((value) {
        if (value == OkCancelResult.ok)
          onPositiveBtnPressed?.call();
        else
          onNegativeBtnPressed?.call();
      });
    });
  }

  void showLoader({String? message}) {
    // hide loader if shown previously
    hideLoader();
    if (message == null) {
      _cpr = CustomProgressDialog(_getSafeContext(),
          loadingWidget: Container(
              padding: const EdgeInsets.all(20),
              child: AppProgressIndicator(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                shape: BoxShape.rectangle,
              )),
          dismissable: true);
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _cpr!.show();
      });
    } else {
      _pr = ProgressDialog(_getSafeContext(),
          title: null,
          dialogStyle: DialogStyle(
            borderRadius: BorderRadius.circular(10.0),
            backgroundColor: Colors.white,
            elevation: 10.0,
          ),
          defaultLoadingWidget: AppProgressIndicator(),
          message: Text(message),
          dismissable: true);

      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _pr!.show();
      });
    }
  }

  void hideLoader() {
    if (_pr?.isShowed ?? false) {
      _pr?.dismiss();
    }
    if (_cpr?.isShowed ?? false) {
      _cpr?.dismiss();
    }
  }
}
