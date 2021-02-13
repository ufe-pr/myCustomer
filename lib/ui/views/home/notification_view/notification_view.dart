import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'notification_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
        onModelReady: (model) => model.getlogs(),
        builder: (context, model, child) => DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: customizeAppBar(context, 0.0,
                      title: AppLocalizations.of(context).notifications,
                      arrowColor: BrandColors.primary),
                  body: Column(
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 1),
                          unselectedLabelColor: Theme.of(context).cursorColor,
                          labelColor: Theme.of(context).buttonColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Theme.of(context).buttonColor,
                          tabs: [
                            Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context).reminders,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: SizeConfig.yMargin(context, 2),
                                    ),
                                    //maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context).activities,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: SizeConfig.yMargin(context, 2),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).noRemindersYet,
                                  style: TextStyle(
                                      fontSize: SizeConfig.yMargin(context, 2)),
                                ),
                              ),
                            ),
                            model.loglist.length == 0
                                ? Center(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .noActivitiesYet,
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.yMargin(context, 2)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (var log in model.loglist)
                                          Dismissible(
                                            key: Key(model.loglist
                                                .indexOf(log)
                                                .toString()),
                                            onDismissed:
                                                (DismissDirection direction) {},
                                            direction:
                                                DismissDirection.endToStart,
                                            background: Container(
                                              padding:
                                                  EdgeInsets.only(right: 15),
                                              color: BrandColors.primary,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .view,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(children: <Widget>[
                                                    Expanded(
                                                        child: Text(
                                                      log.description,
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                              .yMargin(
                                                                  context, 2)),
                                                    )),
                                                    SizedBox(width: 20.0),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          '',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF333CC1),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        Text(
                                                            log.timestamp.day ==
                                                                    DateTime.now()
                                                                        .day
                                                                ? DateFormat(
                                                                        'hh:mm aa')
                                                                    .format(log
                                                                        .timestamp)
                                                                : DateFormat(
                                                                        'MMM dd yyyy')
                                                                    .format(log
                                                                        .timestamp),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ],
                                                    ),
                                                  ])
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
        viewModelBuilder: () => NotificationViewModel());
  }
}
