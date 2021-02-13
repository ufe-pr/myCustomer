import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

/// Customize AppBar to be use across all POP screens
/// - Title
/// - Elevation
Widget customizeAppBar(BuildContext context, double elevation,
    {Color arrowColor, String title}) {
  return AppBar(
    brightness: Brightness.light,
    backgroundColor: Theme.of(context).backgroundColor,
    elevation: elevation,
    centerTitle: true,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline6.copyWith(
        fontSize: SizeConfig.textSize(context, 5),
        color: Theme.of(context).cursorColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: SvgPicture.asset(
          'assets/icons/backarrow.svg',
          color: arrowColor,
        ),
      ),
    ),
    // actions: <Widget>[
    //   FlatButton(
    //     textColor: Colors.white,
    //     onPressed: (){},
    //     child: Text("View",
    //       style: TextStyle(
    //         color: Color(0xFF333CC1),
    //       ),
    //   ),
    //     shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
    //   )
    // ],
  );
}

/// A customize Progress Indicator By Ufedojo Atabo
class CustomizeProgressIndicator extends StatelessWidget {
  final int progress, total;

  const CustomizeProgressIndicator(this.progress, this.total, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(total * 2 - 1, (int index) {
        return index % 2 == 0
            ? CircleAvatar(
                radius: 15,
                child: index <= progress
                    ? Text(
                        '${index ~/ 2 + 1}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : null,
                backgroundColor:
                    index <= progress ? ThemeColors.cta : ThemeColors.gray,
              )
            : Expanded(
                child: Divider(
                  thickness: 5,
                  color: index <= progress ? ThemeColors.cta : ThemeColors.gray,
                ),
              );
      }),
    );
  }
}

Widget btnDesign(String btnText, Color textColor, Color bgColor) {
  return Container(
    height: 200.h,
    width: double.infinity,
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 10.0, right: 10.0),
    decoration: BoxDecoration(
        color: bgColor, borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Text(btnText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontFamily: '',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        )),
  );
}

///Button for the Onboarding Screen
Widget btnHome(String btnText, Color colorBtn, Color colorText, context) {
  return Container(
    height: SizeConfig.yMargin(context, 5),
    width: SizeConfig.xMargin(context, 90),
    decoration: BoxDecoration(
      border: Border.all(color: colorText),
      borderRadius: BorderRadius.circular(6),
      color: colorBtn,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          btnText,
          style: TextStyle(
            color: colorText,
            fontSize: SizeConfig.textSize(context, 4),
          ),
        ),
      ],
    ),
  );
}

/// Authentication Button with variable for
/// - String
/// - Button Color
/// - Function
/// - Text Color
/// - Widget
/// - Border Color
/// - -Use Container() for child, if no widget is suppose to be there
class CustomRaisedButton extends StatelessWidget {
  final Function onPressed;
  final String btnText;
  final Color btnColor;
  final Widget child;
  final Color txtColor;
  final Color borderColor;

  const CustomRaisedButton({
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
      height: SizeConfig.yMargin(context, 5.5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              btnText,
              style: TextStyle(
                color: txtColor,
                fontSize: SizeConfig.yMargin(context, 1.8),
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(width: SizeConfig.xMargin(context, 3)),
            child,
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

///CustomScroll Background to hold all other widget
///
///
class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: BrandColors.primary,
          floating: false,
          expandedHeight: SizeConfig.yMargin(context, 7),
        ),
        SliverFixedExtentList(
          itemExtent: SizeConfig.yMargin(context, 100),
          delegate: SliverChildListDelegate([
            Container(
              constraints: BoxConstraints(
                  // minHeight: SizeConfig.yMargin(context, 100),
                  ),
              decoration: BoxDecoration(
                color: ThemeColors.background,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(SizeConfig.yMargin(context, 4)),
                ),
              ),
              child: child,
            ),
          ]),
        ),
      ],
    );
  }
}

Widget notificationBell(bool isNewNotification, width) {
  String notification = isNewNotification ? 'notification' : 'no_notification';
  final String assetName = "assets/icons/$notification.png";
  final Widget notificationIcon = Image.asset(assetName, width: width);
  return notificationIcon;
}

Widget arrow(bool forward) {
  String direction = forward ? 'foward' : 'back';
  final String assetName = "assets/icons/arrow_$direction.svg";
  final Widget svgIcon = SvgPicture.asset(assetName,
      color: BrandColors.primary, semanticsLabel: 'An arrow');
  return svgIcon;
}

Widget circleDesign(double outerRadius, double innerRadius) {
  return Container(
    height: outerRadius * 2,
    width: outerRadius * 2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(outerRadius),
      color: ThemeColors.link,
    ),
    child: Center(
      child: Container(
        height: innerRadius * 2,
        width: innerRadius * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(outerRadius),
          color: BrandColors.primary,
        ),
      ),
    ),
  );
}
