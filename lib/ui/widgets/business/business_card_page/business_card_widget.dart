part of '../../../views/business/business_card_page/business_cardpage_view.dart';

class BusinessCardWidget extends ViewModelWidget<BusinessCardPageViewModel> {
  BusinessCardWidget({
    Key key,
    @required this.screenshotController,
    this.showArrow: false,
  }) : super(key: key, reactive: true);
  final ScreenshotController screenshotController;
  final bool showArrow;

  @override
  Widget build(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    PageController businessCardController = PageController(initialPage: 0);
    bool canChange = false;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        businessCardController.animateToPage(
          int.parse(model.businessCard.cardDesign),
          duration: new Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        await Future.delayed(new Duration(milliseconds: 500));
        canChange = true;
      },
    );
    return Container(
      height: SizeConfig.yMargin(context, 30),
      child: Stack(
        children: <Widget>[
          Screenshot(
            controller: screenshotController,
            child: PageView(
              onPageChanged: (value) {
                if (canChange) {
                  model.updateBusinessCard(
                    cardDesign: value.toString(),
                  );
                }
              },
              physics: showArrow
                  ? new BouncingScrollPhysics()
                  : new NeverScrollableScrollPhysics(),
              allowImplicitScrolling: true,
              controller: businessCardController,
              children: <Widget>[
                _BusinessCard1(),
                _BusinessCard2(),
                _BusinessCard3(),
                _BusinessCard4(),
              ],
            ),
          ),
          showArrow
              ? Container()
              : Positioned(
                  bottom: SizeConfig.yMargin(context, 2),
                  right: SizeConfig.xMargin(context, 4),
                  child: Column(
                    children: <Widget>[
                      RoundIconButton(
                        icon: Icons.edit,
                        onTap: model.navigateToBusinessCardPage,
                      ),
                      SizedBox(height: 10),
                      RoundIconButton(
                        icon: Icons.share,
                        onTap: () {
                          screenshotController
                              .capture(
                            pixelRatio: ScreenUtil.pixelRatio,
                            delay: Duration(milliseconds: 10),
                          )
                              .then(
                            (File image) {
                              model.imageFile = image;
                              FlushbarHelper.createSuccess(
                                duration: const Duration(seconds: 5),
                                message: 'Sharing...',
                              ).show(context);
                              model.shareImageAndText();
                              FlushbarHelper.createSuccess(
                                duration: const Duration(seconds: 5),
                                message: 'Successful',
                              ).show(context);
                            },
                          ).catchError(
                            (onError) {
                              FlushbarHelper.createError(
                                duration: const Duration(seconds: 5),
                                message: onError.toString(),
                              ).show(context);
                            },
                          );
                          return;
                        },
                      ),
                    ],
                  ),
                ),
          showArrow
              ? Positioned(
                  left: SizeConfig.xMargin(context, 2),
                  top: SizeConfig.yMargin(context, 10),
                  bottom: SizeConfig.yMargin(context, 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: ThemeColors.error,
                      size: SizeConfig.textSize(context, 10),
                    ),
                    onPressed: () => businessCardController.previousPage(
                      duration: new Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                  ),
                )
              : Container(),
          showArrow
              ? Positioned(
                  right: SizeConfig.xMargin(context, 2),
                  top: SizeConfig.yMargin(context, 10),
                  bottom: SizeConfig.yMargin(context, 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_right,
                      color: ThemeColors.error,
                      size: SizeConfig.textSize(context, 10),
                    ),
                    onPressed: () => businessCardController.nextPage(
                      duration: new Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class _BusinessCard1 extends ViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCard1({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.xMargin(context, 1),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.yMargin(context, 30),
            decoration: BoxDecoration(
              color: ThemeColors.background,
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage("assets/images/business_card_1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.yMargin(context, 5),
            left: SizeConfig.xMargin(context, 30),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: model.businessCard.storeName,
                style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 5),
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n${model.businessCard.tagLine.capitalize}',
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 3),
                      color: ThemeColors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: SizeConfig.xMargin(context, 30),
            top: SizeConfig.yMargin(context, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: SizeConfig.textSize(context, 3),
                      color: ThemeColors.black,
                    ),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: "  ${model.businessCard.personalName}",
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3),
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.black,
                        ),
                        // children: <TextSpan>[
                        //   TextSpan(
                        //     text: '\n   ${model.businessCard.position}',
                        //     style: TextStyle(
                        //       fontSize: SizeConfig.textSize(context, 3),
                        //       color: ThemeColors.black,
                        //       fontWeight: FontWeight.normal,
                        //     ),
                        //   ),
                        // ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 0.4),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      size: SizeConfig.textSize(context, 3),
                      color: ThemeColors.black,
                    ),
                    Text(
                      "   ${model.businessCard.phoneNumber}",
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3),
                        color: ThemeColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 0.4),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      size: SizeConfig.textSize(context, 3),
                      color: ThemeColors.black,
                    ),
                    Text(
                      "   ${model.businessCard.emailAddress}",
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3),
                        color: ThemeColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: SizeConfig.yMargin(context, 3),
            left: SizeConfig.xMargin(context, 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: SizeConfig.textSize(context, 3),
                  color: ThemeColors.black,
                ),
                Text(
                  "   ${model.businessCard.address}",
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 3),
                    color: ThemeColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessCard2 extends ViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCard2({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.xMargin(context, 1),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.yMargin(context, 30),
            decoration: BoxDecoration(
              color: ThemeColors.background,
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage("assets/images/business_card_2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.yMargin(context, 4),
            left: SizeConfig.xMargin(context, 25),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: model.businessCard.storeName,
                style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 5),
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.black,
                  fontStyle: FontStyle.italic,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n${model.businessCard.tagLine.capitalize}',
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 3),
                      color: ThemeColors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: SizeConfig.xMargin(context, 25),
            top: SizeConfig.yMargin(context, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: "${model.businessCard.personalName}",
                    style: TextStyle(
                      height: SizeConfig.textSize(context, 0.5),
                      fontSize: SizeConfig.textSize(context, 3),
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.black,
                    ),
                    children: <TextSpan>[
                      // TextSpan(
                      //   text: '\n${model.businessCard.position}',
                      //   style: TextStyle(
                      //     fontSize: SizeConfig.textSize(context, 3),
                      //     color: ThemeColors.black,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),
                      TextSpan(
                        text: '\n${model.businessCard.phoneNumber}',
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3),
                          color: ThemeColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: '\n${model.businessCard.emailAddress}',
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3),
                          color: ThemeColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: SizeConfig.yMargin(context, 2),
            left: SizeConfig.xMargin(context, 25),
            child: Text(
              model.businessCard.address,
              style: TextStyle(
                fontSize: SizeConfig.textSize(context, 3),
                color: ThemeColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessCard3 extends ViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCard3({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.xMargin(context, 1),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.yMargin(context, 30),
            decoration: BoxDecoration(
              color: ThemeColors.background,
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage("assets/images/business_card_3.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.yMargin(context, 5),
            left: SizeConfig.xMargin(context, 50),
            right: SizeConfig.xMargin(context, 5),
            bottom: SizeConfig.yMargin(context, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    text: model.businessCard.storeName,
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 5),
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n${model.businessCard.tagLine.capitalize}',
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3),
                          color: ThemeColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                Text(
                  " ${model.businessCard.phoneNumber}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 3),
                    color: ThemeColors.black,
                  ),
                ),
                Text(
                  " ${model.businessCard.emailAddress}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 3),
                    color: ThemeColors.black,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                Text(
                  model.businessCard.address,
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 3),
                    color: ThemeColors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: SizeConfig.yMargin(context, 5),
            left: SizeConfig.xMargin(context, 5),
            right: SizeConfig.xMargin(context, 60),
            bottom: SizeConfig.yMargin(context, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                    size: SizeConfig.textSize(context, 15),
                  ),
                  minRadius: SizeConfig.textSize(context, 7),
                  maxRadius: SizeConfig.textSize(context, 8),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 1),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "  ${model.businessCard.personalName}",
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 3),
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.background,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n  ${model.businessCard.position}',
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 2),
                          color: ThemeColors.background,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessCard4 extends ViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCard4({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.xMargin(context, 1),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.yMargin(context, 30),
            decoration: BoxDecoration(
              color: ThemeColors.background,
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage("assets/images/business_card_4.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.yMargin(context, 5),
            left: SizeConfig.xMargin(context, 10),
            right: SizeConfig.xMargin(context, 10),
            // TODO change font to Gilroy-Bold
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: model.businessCard.storeName,
                style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 5),
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n${model.businessCard.tagLine.capitalize}',
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 3),
                      color: ThemeColors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: SizeConfig.xMargin(context, 5),
            bottom: SizeConfig.yMargin(context, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: SizeConfig.textSize(context, 4),
                      color: ThemeColors.background,
                    ),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: "  ${model.businessCard.personalName}",
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3),
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.background,
                        ),
                        children: <TextSpan>[
                      //     TextSpan(
                      //       text: '\n   ${model.businessCard.position}',
                      //       style: TextStyle(
                      //         fontSize: SizeConfig.textSize(context, 2),
                      //         color: ThemeColors.background,
                      //         fontWeight: FontWeight.normal,
                      //       ),
                      //     ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 0.7),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      size: SizeConfig.textSize(context, 3),
                      color: ThemeColors.background,
                    ),
                    Text(
                      "   ${model.businessCard.phoneNumber}",
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3),
                        color: ThemeColors.background,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 0.7),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      size: SizeConfig.textSize(context, 3),
                      color: ThemeColors.background,
                    ),
                    Text(
                      "   ${model.businessCard.emailAddress.toLowerCase()}",
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3),
                        color: ThemeColors.background,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: SizeConfig.yMargin(context, 3),
            right: SizeConfig.xMargin(context, 5),
            left: SizeConfig.xMargin(context, 55),
            child: Text(
              model.businessCard.address,
              textAlign: TextAlign.right,
              softWrap: true,
              style: TextStyle(
                fontSize: SizeConfig.textSize(context, 3),
                color: ThemeColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final Function() onTap;

  const RoundIconButton({Key key, this.icon, this.child, this.onTap})
      : assert(icon != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // constraints: BoxConstraints(maxHeight: 100, maxWidth: 100),
      icon: Container(
        child: child ?? Icon(icon, color: Colors.white),
        // padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: BrandColors.primary,
        ),
      ),
      onPressed: onTap,
      padding: EdgeInsets.zero,
    );
  }
}
