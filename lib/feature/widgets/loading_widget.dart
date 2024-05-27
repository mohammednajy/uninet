import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';

loadingWithText({
  String? text,
}) {
  showDialog(
      context: RouteManager.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => Center(
            child: SizedBox(
              height: 100,
              width: 250,
              child: Dialog(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text ?? 'waiting ....',
                    ),
                    const SpinKitDualRing(
                      color: ColorManager.blue,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ));
}

loading() {
  return const Center(
    child: SizedBox(
      height: 150,
      width: 250,
      child: SpinKitWave(
        color: ColorManager.blue,
        size: 50.0,
      ),
    ),
  );
}
