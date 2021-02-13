import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:oktoast/oktoast.dart';

ToastFuture showToastCustom(
    {Key key,
    message,
    success: false,
    color,
    BuildContext context,
    Duration duration: const Duration(seconds: 5)}) {
  assert(success != null || color != null);
  return showToastWidget(
    ToastWidget(
      key: key,
      message: message,
      success: success,
      color: color,
    ),
    duration: duration,
    context: context,
    animationDuration: Duration(milliseconds: 1000),
    animationCurve: Curves.easeInOutBack,
    dismissOtherToast: true,
  );
}

class ToastWidget extends StatelessWidget {
  final String message;
  final bool success;
  final Color color;

  const ToastWidget({Key key, this.message, this.success: false, this.color})
      : assert(success != null || color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor =
        (color?.computeLuminance() ?? 0) > 0.5 ? Colors.black : Colors.white;
    return Padding(
      padding: EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: this.color ?? this.success
                ? ThemeColors.success
                : ThemeColors.error,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            this.message,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
