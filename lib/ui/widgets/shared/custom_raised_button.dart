import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget trailing;

  CustomRaisedButton({
    @required this.label,
    @required this.onPressed, this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50),
      child: RaisedButton(
        onPressed: onPressed,
        color: Color(0xFF333CC1),
        padding: EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing != null ? SizedBox(
              width: 10.0,
            ) : Container(),
            trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
