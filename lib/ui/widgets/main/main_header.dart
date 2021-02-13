part of '../../views/main/main_view.dart';

class MainHeader extends HookViewModelWidget<MainViewModel> {
  MainHeader({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return Positioned(
      top: 0,
      bottom: SizeConfig.yMargin(context, 88),
      width: SizeConfig.xMargin(context, 100),
      child: Container(
        color: BrandColors.primary,
        height: SizeConfig.yMargin(context, 12),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: SizeConfig.yMargin(context, -12.0),
              left: SizeConfig.yMargin(context, -10.0),
              child: circleDesign(
                SizeConfig.yMargin(context, 10),
                SizeConfig.yMargin(context, 7),
              ),
            ),
            Positioned(
              top: SizeConfig.yMargin(context, -12.0),
              right: SizeConfig.yMargin(context, -12.0),
              child: circleDesign(
                SizeConfig.yMargin(context, 10),
                SizeConfig.yMargin(context, 7),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.xMargin(context, 3),
                right: SizeConfig.xMargin(context, 3),
                top: SizeConfig.yMargin(context, 6),
                bottom: SizeConfig.yMargin(context, 2),
              ),
              child: headerBar(context, model),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerBar(
    BuildContext context,
    MainViewModel model,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: model.updateMenu,
          child: Row(
            children: <Widget>[
              Text(
                model.currStore?.name?.capitalize ?? ' none',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.background,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textSize(context, 5),
                ),
              ),
              SizedBox(
                width: SizeConfig.xMargin(context, 2),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: ThemeColors.background,
                size: SizeConfig.textSize(context, 6),
              )
            ],
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
          onTap: model.navigateToNotifications,
          child: Container(
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: SizeConfig.yMargin(context, 3),
                ),
                model.showdot
                    ? Positioned(
                        // draw a red marble
                        top: 0.0,
                        right: 0.0,
                        child: new Icon(Icons.brightness_1,
                            size: SizeConfig.yMargin(context, 1.2),
                            color: Colors.redAccent),
                      )
                    : SizedBox()
              ],
              overflow: Overflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}