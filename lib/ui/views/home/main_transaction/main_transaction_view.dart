import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/pdf/receipt_report_view.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class MainTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    final currency = new NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<MainTransactionViewModel>.reactive(
        onModelReady: (model) {
          model.getTransactions();
        },
        builder: (context, model, child) => WillPopScope(
              onWillPop: () async {
                model.navigateToHome();
                return true;
              },
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(70.0),
                  child: AppBar(
                    brightness: Brightness.dark,
                    elevation: .5,
                    title: Container(
                      margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(15), top: 6),
                      child: Row(
                        children: <Widget>[
                          model.contact.initials != null
                              ? Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(15)),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor:
                                        Theme.of(context).textSelectionColor,
                                    child: Text(
                                      model.contact.initials,
                                      style: TextStyle(
                                          color: ThemeColors.background),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(15)),
                                  width: ScreenUtil().setWidth(50),
                                  height: ScreenUtil().setHeight(50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(50)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/man.png',
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    model.contact.name ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color:
                                                Theme.of(context).cursorColor,
                                            fontSize: SizeConfig.yMargin(
                                                context, 2.4),
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    model.contact.phoneNumber ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color:
                                                Theme.of(context).cursorColor,
                                            fontSize:
                                                SizeConfig.yMargin(context, 2),
                                            fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    leading: InkWell(
                      onTap: () => model.navigateToHome(),
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
                    // actions: <Widget>[
                    //   PopupMenuButton<String>(
                    //     onSelected: (String item) {
                    //       itemAction(item, context);
                    //     },
                    //     itemBuilder: (BuildContext context) {
                    //       return model.items.map((String item) {
                    //         return PopupMenuItem<String>(
                    //           value: item,
                    //           child: Text(
                    //             item,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .headline6
                    //                 .copyWith(
                    //                     fontSize:
                    //                         SizeConfig.yMargin(context, 2)),
                    //           ),
                    //         );
                    //       }).toList();
                    //     },
                    //   )
                    // ],
                    actionsIconTheme:
                        IconThemeData(color: Theme.of(context).cursorColor),
                    backgroundColor: Theme.of(context).backgroundColor,
                    centerTitle: true,
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    model.formattedate.length == 0
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(20)),
                            width: width,
                            color: Theme.of(context).backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    model.navigateToSchedule();
                                  },
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(5),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/message.svg',
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .reminder,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.2),
                                                    color: Theme.of(context)
                                                        .textSelectionColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    ReceiptReport().buildPdf(context);
                                    await ReceiptReport()
                                        .generateReport(context);
                                  },
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom:
                                                  ScreenUtil().setHeight(5)),
                                          child: SvgPicture.asset(
                                            'assets/images/pdf.svg',
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            AppLocalizations.of(context).report,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.2),
                                                    color: Theme.of(context)
                                                        .textSelectionColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {}, //Todo: Message Functionality
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(5),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/msg.svg',
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            AppLocalizations.of(context).sms,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.2),
                                                    color: Theme.of(context)
                                                        .textSelectionColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {}, //Todo: Call Functionality
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(5),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/phone_device.svg',
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            AppLocalizations.of(context).call,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.2),
                                                    color: Theme.of(context)
                                                        .textSelectionColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    model.formattedate.length == 0
                        ? Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                  child: Center(
                                      child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                      'assets/images/no_transaction_check.svg'),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                      "${AppLocalizations.of(context).isSafeAndSecure} + "
                                      " + ${model.contact.name} + "
                                      " +  ${AppLocalizations.of(context).canViewThisTransaction}"
                                      // 'MyCustomer is 100% safe and secure, only you and \
                                      // ${model.contact.name} can view this transaction',
                                      // textAlign: TextAlign.center,
                                      ),
                                ],
                              ))),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: model.formattedate.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: StickyHeader(
                                      header: Column(
                                        children: <Widget>[
                                          model.formattedate.length == 0
                                              ? SizedBox()
                                              : Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: ScreenUtil()
                                                        .setWidth(25),
                                                    vertical:
                                                        SizeConfig.yMargin(
                                                            context, 2),
                                                  ),
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            SizeConfig.xMargin(
                                                                context, 3),
                                                        vertical: ScreenUtil()
                                                            .setHeight(10),
                                                      ),
                                                      // margin: EdgeInsets.only(
                                                      //   bottom: ScreenUtil().setHeight(5),
                                                      // ),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor),
                                                      width: width,
                                                      child:
                                                          model.bought() >
                                                                  model.paid()
                                                              ? Center(
                                                                  child: Wrap(
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        '${model.contact.name}' +
                                                                            AppLocalizations.of(context).owesYou +
                                                                            ' ',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5
                                                                            .copyWith(
                                                                              fontSize: SizeConfig.yMargin(context, 2.3),
                                                                              color: Theme.of(context).cursorColor,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        model.currency.symbol +
                                                                            currency.format(model.bought() - model.paid()).toString(),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5
                                                                            .copyWith(
                                                                              fontSize: SizeConfig.yMargin(context, 2.5),
                                                                              color: Color(0xFFEB5757),
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w900,
                                                                            ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : Center(
                                                                  child: Wrap(
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        'You owe ${model.contact.name} ',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5
                                                                            .copyWith(
                                                                              fontSize: SizeConfig.yMargin(context, 2.3),
                                                                              color: Theme.of(context).cursorColor,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        model.currency.symbol +
                                                                            currency.format(model.paid() - model.bought()).toString(),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5
                                                                            .copyWith(
                                                                              fontSize: SizeConfig.yMargin(context, 2.4),
                                                                              color: Color(0xFFEB5757),
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w900,
                                                                            ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )),
                                                ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenUtil().setHeight(10),
                                            ),
                                            margin: EdgeInsets.only(
                                              bottom: ScreenUtil().setHeight(8),
                                            ),
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            child: Center(
                                              child: Text(
                                                model.formattedate[index]
                                                    .toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(
                                                      fontSize:
                                                          SizeConfig.yMargin(
                                                              context, 2.2),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setWidth(20),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            for (var item in model.transactions)
                                              Column(
                                                children: <Widget>[
                                                  item.boughtdate != null
                                                      ? model.getDate(item
                                                                      .boughtdate) ==
                                                                  model.formattedate[
                                                                      index] &&
                                                              item.amount != 0
                                                          ? InkWell(
                                                              onTap: () => model
                                                                  .navigateDetails(
                                                                      item),
                                                              child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom: ScreenUtil()
                                                                      .setHeight(
                                                                          15),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                        bottom:
                                                                            ScreenUtil().setHeight(5),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 8),
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5), horizontal: SizeConfig.xMargin(context, 3)),
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(color: Color(0xFFE8E8E8), width: 1.5),
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: Theme.of(context).backgroundColor),
                                                                            child:
                                                                                Text(
                                                                              model.currency.symbol + currency.format(item.amount).toString(),
                                                                              style: Theme.of(context).textTheme.headline5.copyWith(
                                                                                    fontSize: SizeConfig.yMargin(context, 3),
                                                                                    color: Theme.of(context).textSelectionColor,
                                                                                    fontWeight: FontWeight.w900,
                                                                                    fontFamily: 'Roboto',
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Flexible(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    '${model.contact.name}' + AppLocalizations.of(context).owesYou,
                                                                                    style: Theme.of(context).textTheme.headline5.copyWith(
                                                                                          fontSize: SizeConfig.yMargin(context, 2.2),
                                                                                          color: Theme.of(context).cursorColor,
                                                                                          fontWeight: FontWeight.w400,
                                                                                        ),
                                                                                  ),
                                                                                  // Text(
                                                                                  //   'Click to view Transaction Details',
                                                                                  //   style: Theme.of(context).textTheme.headline5.copyWith(fontSize: SizeConfig.yMargin(context, 1.5), color: Colors.black38, fontWeight: FontWeight.w400),
                                                                                  // )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        model.getTime(
                                                                            item.boughtdate),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5
                                                                            .copyWith(
                                                                              fontSize: SizeConfig.yMargin(context, 1.8),
                                                                              color: Theme.of(context).cursorColor,
                                                                            ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox()
                                                      : SizedBox(),
                                                  item.paiddate != null
                                                      ? model.getDate(item
                                                                      .paiddate) ==
                                                                  model.formattedate[
                                                                      index] &&
                                                              item.paid != 0
                                                          ? InkWell(
                                                              onTap: () => model
                                                                  .navigateDetails(
                                                                      item),
                                                              child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom: ScreenUtil()
                                                                      .setHeight(
                                                                          15),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                        bottom:
                                                                            ScreenUtil().setHeight(5),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            child:
                                                                                Flexible(
                                                                              child: Text(
                                                                                AppLocalizations.of(context).youOwe + ' ' + '${model.contact.name}',
                                                                                style: Theme.of(context).textTheme.headline5.copyWith(
                                                                                      fontSize: SizeConfig.yMargin(context, 2.2),
                                                                                      color: Theme.of(context).cursorColor,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 8),
                                                                            padding:
                                                                                EdgeInsets.symmetric(
                                                                              vertical: SizeConfig.yMargin(context, 1.5),
                                                                              horizontal: SizeConfig.xMargin(context, 3),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                color: Color(0xFFE8E8E8),
                                                                                width: 1.5,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              //color: Theme.of(context).cursorColor
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              model.currency.symbol + currency.format(item.paid).toString(),
                                                                              style: Theme.of(context).textTheme.headline5.copyWith(
                                                                                    fontSize: SizeConfig.yMargin(context, 3),
                                                                                    color: Color(0xFF21D184),
                                                                                    fontWeight: FontWeight.w900,
                                                                                    fontFamily: 'Roboto',
                                                                                  ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        model.getTime(
                                                                            item.paiddate),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5
                                                                            .copyWith(
                                                                              fontSize: SizeConfig.yMargin(context, 1.8),
                                                                              color: Theme.of(context).cursorColor,
                                                                            ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox()
                                                      : SizedBox()
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                    Container(
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: ScreenUtil().setWidth(25),
                      //   vertical: ScreenUtil().setHeight(12),
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // model.formattedate.length == 0
                          //     ? SizedBox()
                          //     : Container(
                          //         padding: EdgeInsets.symmetric(
                          //           horizontal: ScreenUtil().setWidth(25),
                          //           vertical: SizeConfig.yMargin(context, 2),
                          //         ),
                          //         child: Container(
                          //             padding: EdgeInsets.symmetric(
                          //               horizontal:
                          //                   SizeConfig.xMargin(context, 3),
                          //               vertical: ScreenUtil().setHeight(10),
                          //             ),
                          //             // margin: EdgeInsets.only(
                          //             //   bottom: ScreenUtil().setHeight(5),
                          //             // ),
                          //             decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(50),
                          //                 color: Theme.of(context)
                          //                     .backgroundColor),
                          //             width: width,
                          //             child: model.bought() > model.paid()
                          //                 ? Center(
                          //                     child: Wrap(
                          //                       alignment: WrapAlignment.center,
                          //                       children: <Widget>[
                          //                         Text(
                          //                           '${model.contact.name} ' + AppLocalizations.of(context).owesYou  + ' ',
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.3),
                          //                                 color:
                          //                                     Theme.of(context)
                          //                                         .cursorColor,
                          //                               ),
                          //                         ),
                          //                         Text(
                          //                           model.currency.symbol +
                          //                               currency
                          //                                   .format(model
                          //                                           .bought() -
                          //                                       model.paid())
                          //                                   .toString(),
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.5),
                          //                                 color:
                          //                                     Color(0xFFEB5757),
                          //                                 fontFamily: 'Roboto',
                          //                                 fontWeight:
                          //                                     FontWeight.w900,
                          //                               ),
                          //                         )
                          //                       ],
                          //                     ),
                          //                   )
                          //                 : Center(
                          //                     child: Wrap(
                          //                       alignment: WrapAlignment.center,
                          //                       children: <Widget>[
                          //                         Text(
                          //                           'You owe ${model.contact.name} ',
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.3),
                          //                                 color:
                          //                                     Theme.of(context)
                          //                                         .cursorColor,
                          //                               ),
                          //                         ),
                          //                         Text(
                          //                           model.currency.symbol +
                          //                               currency
                          //                                   .format(model
                          //                                           .paid() -
                          //                                       model.bought())
                          //                                   .toString(),
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.5),
                          //                                 color:
                          //                                     Color(0xFFEB5757),
                          //                                 fontFamily: 'Roboto',
                          //                                 fontWeight:
                          //                                     FontWeight.w900,
                          //                               ),
                          //                         )
                          //                       ],
                          //                     ),
                          //                   )),
                          //       ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(25),
                                vertical: SizeConfig.yMargin(context, 2),
                              ),
                              child: AddTransaction(
                                  width, model.debitlist, model.creditlist)),
//                        InkWell(
//                          onTap: () {
//
//                            showBottomSheet(context: context,
//                            builder: (context)=> Container());
//                          },
//                          child: Container(
//                            padding: EdgeInsets.symmetric(
//                              vertical: ScreenUtil().setHeight(15),
//                            ),
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(5.0),
//                              color: Color(0xFF333CC1),
//                            ),
//                            width: width,
//                            child: Center(
//                              child: Text(
//                                'Add Transaction',
//                                style: Theme.of(context)
//                                    .textTheme
//                                    .headline6
//                                    .copyWith(
//                                      fontSize: ScreenUtil().setSp(16),
//                                      color: Colors.white,
//                                      fontWeight: FontWeight.bold,
//                                    ),
//                              ),
//                            ),
//                          ),
//                        )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => MainTransactionViewModel());
  }

  void itemAction(String item, BuildContext context) {
    if (item == AppLocalizations.of(context).sms) {
      // Navigator.pushNamed(context, '/transactionHistory');
      //TODO: Code to send sms
    } else if (item == AppLocalizations.of(context).call) {
      // Navigator.pushNamed(context, '/transactionDetails');
      //TODO: Code to call customer
    } else {
      //
    }
  }
}

class AddTransaction extends StatelessWidget {
  final double width;
  final List<TransactionModel> debitlist;
  final List<TransactionModel> creditlist;
  AddTransaction(this.width, this.debitlist, this.creditlist);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   showModalBottomSheet(
      //       context: context,
      //       barrierColor: Colors.black.withOpacity(0.5),
      //       builder: (context) => Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Container(
      //               height: SizeConfig.yMargin(context, 30),
      //               child: Column(
      //                 children: <Widget>[
      //                   InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                         creditlist.length == 0
      //                             ? Navigator.pushNamed(context, '/addDebt')
      //                             : Navigator.pushNamed(
      //                                 context, '/selectCredit');
      //                       },
      //                       child: Container(
      //                           height: SizeConfig.yMargin(context, 8),
      //                           child: Center(
      //                               child: Text(
      //                             'Add Debt',
      //                             style: TextStyle(
      //                                 color:
      //                                     Theme.of(context).textSelectionColor,
      //                                 fontSize:
      //                                     SizeConfig.yMargin(context, 2.3)),
      //                           )))),
      //                   Divider(color: Colors.black.withOpacity(0.5)),
      //                   InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                         debitlist.length == 0
      //                             ? Navigator.pushNamed(context, '/addCredit')
      //                             : Navigator.pushNamed(context, '/selectDebt');
      //                       },
      //                       child: Container(
      //                           height: SizeConfig.yMargin(context, 8),
      //                           child: Center(
      //                               child: Text(
      //                             'Add Credit',
      //                             style: TextStyle(
      //                                 color: BrandColors.secondary,
      //                                 fontSize:
      //                                     SizeConfig.yMargin(context, 2.3)),
      //                           )))),
      //                   Divider(color: Colors.black.withOpacity(0.5)),
      //                   InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: Container(
      //                           height: SizeConfig.yMargin(context, 8),
      //                           child: Center(
      //                               child: Text(
      //                             'Cancel',
      //                             style: TextStyle(
      //                                 color: Colors.red,
      //                                 fontSize:
      //                                     SizeConfig.yMargin(context, 2.3)),
      //                           )))),
      //                 ],
      //               ),
      //             ),
      //           ));
      // },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              creditlist.length == 0
                  ? Navigator.pushNamed(context, '/addDebt')
                  : Navigator.pushNamed(context, '/selectCredit');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(15),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: BrandColors.secondary,
              ),
              width: width / 2.5,
              child: Center(
                child: Text(
//'They are owing you',
                  AppLocalizations.of(context).theyAreOwingYou,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: SizeConfig.yMargin(context, 2),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              debitlist.length == 0
                  ? Navigator.pushNamed(context, '/addCredit')
                  : Navigator.pushNamed(context, '/selectDebt');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(15),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).textSelectionColor,
              ),
              width: width / 2.5,
              child: Center(
                child: Text(
                  //"You are owing them",
                  AppLocalizations.of(context).youAreOwingThem,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: SizeConfig.yMargin(context, 2),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
