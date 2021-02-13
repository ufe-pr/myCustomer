import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/views/home/transaction_history/transaction_history_viewmodel.dart';

class TransactionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<TransactionHistoryViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                brightness: Brightness.light,
                elevation: 1,
                title: Text(
                  AppLocalizations.of(context).transactionHistory,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                ),
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(18),
                        vertical: ScreenUtil().setHeight(10)),
                    child: SvgPicture.asset('assets/icons/backarrow.svg'),
                  ),
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(20),
                          horizontal: ScreenUtil().setWidth(20)),
                      width: width,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(15)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(15)),
                                  width: ScreenUtil().setWidth(70),
                                  height: ScreenUtil().setHeight(70),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(50)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/man.png',
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          'Seyi Onifade',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize:
                                                      ScreenUtil().setSp(22),
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '08035678290',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    AppLocalizations.of(context).selectDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontSize: ScreenUtil().setSp(20),
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(10)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(10)),
                                      color: Colors.white),
                                  child: DropdownButton<String>(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconSize: ScreenUtil().setWidth(30),
                                      value: model.value,
                                      items: model.drop
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                            width: ScreenUtil().setWidth(120),
                                            child: Text(
                                              value,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontSize: ScreenUtil().setSp(18),
                                              fontWeight: FontWeight.w500),
                                      underline: SizedBox(),
                                      onChanged: (value) async {
                                        if (value ==
                                            AppLocalizations.of(context)
                                                .selectADate) {
                                          final DateTime picked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      model.selectedDate,
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(
                                                      int.parse(DateFormat(
                                                              'yyyy')
                                                          .format(
                                                              DateTime.now())),
                                                      int.parse(DateFormat('MM')
                                                          .format(
                                                              DateTime.now())),
                                                      int.parse(DateFormat('dd')
                                                          .format(DateTime
                                                              .now()))));
                                          if (picked != null)
                                            model.setDate(picked);
                                        } else if (value ==
                                            AppLocalizations.of(context).all) {
                                          model.loadAll();
                                        } else {
                                          model.setValue(value);
                                        }
                                      }),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(12),
                          horizontal: ScreenUtil().setWidth(6)),
                      color: Color(0xFF333cc1).withOpacity(0.05),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(15)),
                            width: ScreenUtil().setWidth(width * 0.38),
                            child: Text(
                              AppLocalizations.of(context).details,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: ScreenUtil().setSp(18),
                                      fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(10)),
                            width: ScreenUtil().setWidth(width * 0.28),
                            child: Text(
                              AppLocalizations.of(context).payedYou,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w900),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(10)),
                            width: ScreenUtil().setWidth(width * 0.28),
                            child: Text(
                              AppLocalizations.of(context).owesYou,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: model.date.length > 0
                          ? ListView.builder(
                              itemCount: model.date.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFFC4C4C4),
                                              width:
                                                  ScreenUtil().setWidth(2)))),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                ScreenUtil().setHeight(10),
                                            horizontal:
                                                ScreenUtil().setWidth(8)),
                                        color: Color(0xFFE8E8E8),
                                        width:
                                            ScreenUtil().setWidth(width * 0.4),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              model.date[index] +
                                                  ' - ' +
                                                  model.time[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.3),
                                            ),
                                            Text(
                                              model.purchase[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.5),
                                            ),
                                            Text(
                                              'N' +
                                                  (model.payed[index] +
                                                          model.owes[index])
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      color: Color(0xFF333CC1),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.5),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            ScreenUtil().setWidth(width * 0.28),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        child: Text(
                                          'N' + model.payed[index].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  color: Color(0xFF21D184),
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.5),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            ScreenUtil().setWidth(width * 0.25),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        child: Text(
                                          'N' + model.payed[index].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  color: Color(0xFFC80515),
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.5),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })
                          : Center(
                              child: Text(
                                AppLocalizations.of(context).noTransaction,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => TransactionHistoryViewModel());
  }
}
