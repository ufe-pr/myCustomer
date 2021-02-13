import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/settings/currency_settings_page/currency_settings_page_viewmodel.dart';
import 'package:mycustomers/ui/widgets/shared/custom_raised_button.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/widgets/shared/saved_dialog.dart';
import 'package:stacked/stacked.dart';

class CurrencySettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<CurrencySettingPageViewModel>.reactive(
        builder: (context, model, child) => WillPopScope(
          onWillPop: ()async {
            model.resetCurrency();
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                  brightness: Brightness.light,
                  elevation: 0,
                  title: Text(
                   AppLocalizations.of(context).currency,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).cursorColor,
                        ),
                  ),
                  leading: InkWell(
                    onTap: () {
                      model.resetCurrency();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(18),
                          vertical: ScreenUtil().setHeight(10)),
                      child: SvgPicture.asset(
                        'assets/icons/backarrow.svg',
                        color: Theme.of(context).textSelectionColor,
                      ),
                    ),
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                  centerTitle: true,
                ),
                body: Container(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(20),
                                horizontal: ScreenUtil().setWidth(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .selectYourCurrency,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontSize:
                                                SizeConfig.yMargin(context, 2.7),
                                            color: Theme.of(context).cursorColor),
                                  ),
                                ),
                                for (var curr in model.currencies)
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                                    child: currTile(
                                        context,
                                        curr['name'],
                                        curr['selected'],
                                        model,
                                        model.currencies.indexOf(curr)),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20)),
                          child: CustomRaisedButton(
                              label: AppLocalizations.of(context).save,
                              onPressed: () {
                                model.saveCurrencyIndex();
                                Navigator.pop(context);
                                SavedDialog().showSavedDialog(context);
                              }))
                    ],
                  ),
                ),
              ),
        ),
        viewModelBuilder: () => CurrencySettingPageViewModel());
  }

  InkWell currTile(BuildContext context, String text, bool selected,
      CurrencySettingPageViewModel model, int index) {
    return InkWell(
      onTap: () {
        model.selectCurrency(index);
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: selected
                      ? Theme.of(context).textSelectionColor
                      : Color(0xFFE8E8E8),
                  width: 1.0)),
          child: ListTile(
            leading: Container(
              width: ScreenUtil().setWidth(55),
              height: ScreenUtil().setHeight(55),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55),
                  color: selected ? Color(0xFF219653) : Color(0xFFD1D1D1)),
              child: Center(
                child: SvgPicture.asset('assets/icons/$text.svg'),
              ),
            ),
            title: Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(text,
                style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: SizeConfig.yMargin(context, 2.6),
                  color: Theme.of(context).cursorColor,
                )
              ),
            ),
          )),
    );
  }
}
