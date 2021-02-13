import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/settings/settings_page/settings_page_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/theme/theme_viewmodel.dart';
import 'package:mycustomers/ui/widgets/shared/partial_build.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SettingsPageViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: customizeAppBar(context, 1.0,
                  title: AppLocalizations.of(context).settings,
                  arrowColor: BrandColors.primary),
              body: Container(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          CustomPartialBuild<SettingManagerModel>(
                            builder: (context, viewModel) => cardTile(
                              AppLocalizations.of(context).changeLanguage,
                              viewModel.selectedLanguage,
                              //Todo: Set Functionality to Change when Language is Changed,
                              model.navigateToLanguageSettings,
                              context),),
                          cardTile(
                              AppLocalizations.of(context).changeCurrency,
                              model.currs[model.currIndex]['name'],
                              //Todo: Set Functionality to Change when Language is Changed
                              model.navigateToCurrency,
                              context),
                          cardTile(AppLocalizations.of(context).appLock, '',
                              model.navigateToAppLock, context),
                          SizedBox(
                            height: ScreenUtil().setHeight(50),
                          ),
                          CustomPartialBuild<SettingManagerModel>(
                            builder: (context, viewModel) => switchTile(
                                context,
                                viewModel.isDarkTheme,
                                viewModel.setTheme,
                                AppLocalizations.of(context).darkMode),
                          ),
                          switchTile(
                              context,
                              model.notification,
                              model.setNotification,
                              AppLocalizations.of(context)
                                  .receiveNotifications),
                          // switchTile(
                          //     context,
                          //     model.newsletter,
                          //     model.setNewsletter,
                          //     AppLocalizations.of(context).receiveNewsletters),
                          // switchTile(
                          //     context,
                          //     model.special,
                          //     model.setSpecial,
                          //     AppLocalizations.of(context)
                          //         .receiveSpecialOffers),
                          // switchTile(context, model.update, model.setUpdate,
                          //     AppLocalizations.of(context).receiveUpdates),
                        ],
                      )),
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: ScreenUtil().setWidth(20)),
                    //   child: crb.CustomRaisedButton(
                    //       label: 'Save',
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       }),
                    // ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => SettingsPageViewModel());
  }

  Container cardTile(
      String text, String subtext, Function func, BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: ScreenUtil().setWidth(1.0),
                    color: Color(0xFFE5E5EE)))),
        child: ListTile(
          onTap: func,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: SizeConfig.yMargin(context, 2),
                      color: Theme.of(context).cursorColor,
                    ),
              ),
              Text(
                subtext ?? '',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: SizeConfig.yMargin(context, 1.6),
                    color: Theme.of(context).cursorColor),
              )
            ],
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow_right.svg',
            color: Theme.of(context).cursorColor,
          ),
        ));
  }

  Container switchTile(
      BuildContext context, bool value, Function func, String text) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(3)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: ScreenUtil().setWidth(1.0),
                    color: Color(0xFFE5E5EE).withOpacity(0.1)))),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: SizeConfig.yMargin(context, 2),
                      color: Theme.of(context).cursorColor,
                    ),
              )
            ],
          ),
          trailing: InkWell(
            onTap: func,
            child: Container(
              height: ScreenUtil().setHeight(33),
              width: ScreenUtil().setHeight(55),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: value ? Color(0xFF333CC1) : Color(0xFFD1D1D1)),
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    top: ScreenUtil().setHeight(2.4),
                    left: value
                        ? ScreenUtil().setWidth(25.0)
                        : ScreenUtil().setWidth(3.0),
                    right: value
                        ? ScreenUtil().setWidth(3.0)
                        : ScreenUtil().setWidth(25.0),
                    child: Container(
                      width: ScreenUtil().setWidth(28),
                      height: ScreenUtil().setHeight(28),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
