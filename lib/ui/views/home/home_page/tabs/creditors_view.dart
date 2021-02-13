import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import '../home_page_viewmodel.dart';

class CreditorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    final currency = new NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  physics: model.owedcustomers.length == 0
                      ? NeverScrollableScrollPhysics()
                      : BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.yMargin(context, 2.0)),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: BrandColors.primary,
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                    'assets/images/Mask Group.png',
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .youAreOwingCustomers,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.yMargin(context, 2),
                                ),
                              ),
                              model.whatyouowe > 0
                                  ? Text(
                                      model.currency.symbol +
                                          currency
                                              .format(model.whatyouowe)
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              SizeConfig.yMargin(context, 5),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold),
                                    )
                                  : RichText(
                                      text: TextSpan(
                                          text: model.currency.symbol + '0.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig.yMargin(
                                                  context, 5),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '00',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: SizeConfig.yMargin(
                                                      context, 3),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      model.owedcustomers.length == 0
                          ? Container(
                              height: height / 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/images/no-transaction-cred.svg',
                                      height: SizeConfig.yMargin(context, 18),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.yMargin(context, 3),
                                          horizontal:
                                              SizeConfig.xMargin(context, 8)),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .youCurrentlyDoNotOweAnyPerson,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF7276A9),
                                            fontSize:
                                                SizeConfig.yMargin(context, 2)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ContactList(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: InkWell(
                onTap: () => model.navigateToCredit(),
                child: Container(
                  height: 50.h,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: BrandColors.primary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).addPeopleYouOwe,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.yMargin(context, 2.2),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}

class ContactList extends StatelessWidget {
  final currency = new NumberFormat("#,##0", "en_NG");
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
              child: TextField(
                //controller: model.allCustomersController,
                //onChanged: model.searchAllCustomers,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).searchByName,
                  hintStyle: TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.only(top: 18.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: BrandColors.primary,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: model.searchCName,
              ),
            ),
            model.sCName != null && !model.containsC
                ? Text(
                    'No Customer Found',
                    style: TextStyle(fontSize: SizeConfig.yMargin(context, 2)),
                  )
                : SizedBox(),
            for (var cont in model.owedcustomers)
              for (var item in model.contacts)
                item.id == cont.cId
                    ? model.sCName != null && model.containsC
                        ? item.name
                                .toLowerCase()
                                .contains(model.sCName.toLowerCase())
                            ? Container(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    top: BorderSide(color: Color(0xFFD1D1D1)),
                                    //bottom: BorderSide(color: Color(0xFFD1D1D1))
                                  )),
                                  child: ListTile(
                                    onTap: () => model.setContact(
                                        item.id,
                                        item.name,
                                        item.phoneNumber,
                                        item.initials),
                                    leading: item.initials != null
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                BrandColors.primary,
                                            child: Text(item.initials),
                                          )
                                        : Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.black,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/images/man.png',
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                    title: Text(item.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: SizeConfig.yMargin(
                                                context, 2))),
                                    /*subtitle: Text(
                      DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7 == 0 ?(DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7).toString()+' weeks' : (DateTime.now().difference(DateTime.parse(cont.duedate)).inDays).toString()+' days'
                    ),*/
                                    trailing: Container(
                                      child: Text(
                                        model.currency.symbol +
                                            currency
                                                .format(
                                                    (cont.paid - cont.amount)
                                                        .round())
                                                .toString(),
                                        style: TextStyle(
                                            color: cont.paiddate == null
                                                ? BrandColors.secondary
                                                : (DateTime.now()
                                                            .difference(DateTime
                                                                .parse(cont
                                                                    .paiddate))
                                                            .inDays) >
                                                        0
                                                    ? Colors.red
                                                    : Colors.green,
                                            fontSize: SizeConfig.yMargin(
                                                context, 1.8),
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox()
                        : model.sCName != null && !model.containsC
                            ? SizedBox()
                            : Container(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    top: BorderSide(color: Color(0xFFD1D1D1)),
                                    //bottom: BorderSide(color: Color(0xFFD1D1D1))
                                  )),
                                  child: ListTile(
                                    onTap: () => model.setContact(
                                        item.id,
                                        item.name,
                                        item.phoneNumber,
                                        item.initials),
                                    leading: item.initials != null
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                BrandColors.primary,
                                            child: Text(item.initials),
                                          )
                                        : Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.black,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/images/man.png',
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                    title: Text(item.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: SizeConfig.yMargin(
                                                context, 2))),
                                    /*subtitle: Text(
                    DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7 == 0 ?(DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7).toString()+' weeks' : (DateTime.now().difference(DateTime.parse(cont.duedate)).inDays).toString()+' days'
                  ),*/
                                    trailing: Container(
                                      child: Text(
                                        model.currency.symbol +
                                            currency
                                                .format(
                                                    (cont.paid - cont.amount)
                                                        .round())
                                                .toString(),
                                        style: TextStyle(
                                            color: cont.paiddate == null
                                                ? BrandColors.secondary
                                                : (DateTime.now()
                                                            .difference(DateTime
                                                                .parse(cont
                                                                    .paiddate))
                                                            .inDays) >
                                                        0
                                                    ? Colors.red
                                                    : Colors.green,
                                            fontSize: SizeConfig.yMargin(
                                                context, 1.8),
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                    : SizedBox()
          ],
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}
