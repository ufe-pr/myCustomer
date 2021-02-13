import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class CustomShareRaisedButton extends StatelessWidget {
  final Function onPressed;
  final String btnText;
  final Color btnColor;
  final Widget child;
  final Color txtColor;
  final Color borderColor;

  const CustomShareRaisedButton({
    Key key,
    @required this.btnText,
    @required this.onPressed,
    @required this.btnColor,
    @required this.txtColor,
    this.borderColor,
    this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: SizeConfig.xMargin(context, 90),
      height: SizeConfig.yMargin(context, 7),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            child,
            SizedBox(
              width: SizeConfig.xMargin(context, 2),
            ),
            Text(
              btnText,
              style: TextStyle(
                color: txtColor,
                fontSize: SizeConfig.textSize(context, 5),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
        color: btnColor,
        elevation: 3,
        // disabledColor: ,
      ),
    );
  }
}
