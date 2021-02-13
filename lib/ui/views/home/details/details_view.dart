import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'details_viewmodel.dart';
import 'package:flutter_screenutil/size_extension.dart';

class DetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);

    return ViewModelBuilder<DetailsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child: Container(
          //  height:  ,
          child: Column(
            children: <Widget>[
              Container(
                height: 80.h,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          //onPressed Method
                          model.navigateToHome();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: ScreenUtil().setWidth(30),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setWidth(32),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Seyi onifade',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '08023456788',
                            style: TextStyle(
                              color: Color(0xFF575A65),
                              fontSize: ScreenUtil().setSp(14),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black.withOpacity(0.5)),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          //onTap method
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.book,
                              color: Color(0xFF333CC1),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            Text(
                              AppLocalizations.of(context).downloadReport,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF333CC1),
                                fontSize: ScreenUtil().setSp(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // onTap method
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.textsms,
                              color: Color(0xFF333CC1),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            Text(
                              AppLocalizations.of(context).sendReminder,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF333CC1),
                                fontSize: ScreenUtil().setSp(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Expanded(
                child: Container(
                  child: Center(
                      child: Text(
                          AppLocalizations.of(context).transactionsGoHere)),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(60),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).youOwe,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4f4f4f),
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "\$8,000",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF21D184),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black.withOpacity(0.5)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: ScreenUtil().setHeight(60),
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            //onTap
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(width / 2 - 14),
                            height: ScreenUtil().setHeight(50),
                            decoration: BoxDecoration(
                                color: Color(0xFF21D184),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).collecting,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            //onTap
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(width / 2 - 14),
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: Color(0xFFBF0413),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).giving,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
      viewModelBuilder: () => DetailsViewModel(),
    );
  }
}
