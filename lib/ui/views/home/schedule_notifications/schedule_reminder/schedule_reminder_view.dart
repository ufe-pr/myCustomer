import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'schedule_reminder_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/core/services/notifications/notifications_reminder.dart';
import 'package:mycustomers/ui/views/home/schedule_notifications/schedule_reminder/widgets/timeWheel.dart';

class ScheduleNotifications extends StatelessWidget {
  final _heading = TextEditingController();
  final _description = TextEditingController();
  final _schedule = GlobalKey<FormState>();
  // This is temporary to give each notification a unique id
  int random = Random().nextInt(100);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);

    NotificationRemindersService reminders = NotificationRemindersService();

    return ViewModelBuilder<ScheduleNotificationsViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customizeAppBar(context, 1.0,
                title: AppLocalizations.of(context).scheduleReminder,
                arrowColor: Theme.of(context).textSelectionColor),
            body: Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .pickADateAndTypeInYourMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Form(
                              key: _schedule,
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      final DateTime picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: model.selectedDate,
                                        firstDate: DateTime(
                                            int.parse(DateFormat('yyyy')
                                                .format(DateTime.now())),
                                            int.parse(DateFormat('MM')
                                                .format(DateTime.now())),
                                            int.parse(DateFormat('dd')
                                                .format(DateTime.now()))),
                                        lastDate: DateTime(2300),
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              primaryColor: BrandColors.primary,
                                              accentColor: BrandColors.primary,
                                              colorScheme: Theme.of(context)
                                                  .colorScheme
                                                  .copyWith(
                                                      primary:
                                                          BrandColors.primary),
                                              buttonTheme: ButtonThemeData(
                                                  textTheme:
                                                      ButtonTextTheme.primary),
                                            ),
                                            child: child,
                                          );
                                        },
                                      );
                                      if (picked != null) model.setDate(picked);
                                      print(model.scheduledDate);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(15),
                                          horizontal:
                                              ScreenUtil().setWidth(15)),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFFD1D1D1),
                                              width: 2.0),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(5))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              model.newDate ??
                                                  AppLocalizations.of(context)
                                                      .selectDate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    color:
                                                        BrandColors.greyedText,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    ScreenUtil().setWidth(15)),
                                            child: SvgPicture.asset(
                                                'assets/icons/calendar.svg',
                                                color: BrandColors.greyedText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      child: TimeWheel(
                                        updateTimeChanged: (val) =>
                                            model.updateSelectedTime(val),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .fieldShouldNotBeEmpty;
                                        }
                                        return null;
                                      },
                                      controller: _heading,
                                      style: TextStyle(height: height * 0.002),
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)
                                            .typeAHeading,
                                        hintStyle: TextStyle(
                                            color: BrandColors.greyedText),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .fieldShouldNotBeEmpty;
                                        }
                                        return null;
                                      },
                                      controller: _description,
                                      style: TextStyle(height: height * 0.002),
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)
                                            .startTypingYourmessage,
                                        hintStyle: TextStyle(
                                            color: BrandColors.greyedText),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ThemeColors.gray,
                                              width: 2.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    height: height * 0.06,
                    child: MaterialButton(
                      color: BrandColors.primary,
                      elevation: 2,
                      onPressed: () async {
                        if (_schedule.currentState.validate()) {
                          reminders.sendNotificationOnce(
                              random,
                              'You have this pending message to send',
                              'Heading: ' + _heading.text,
                              model.getDateTime());
                          Flushbar(
                            backgroundColor: BrandColors.primary,
                            duration: const Duration(seconds: 3),
                            message: 'Your Reminder have been set successfully',
                            icon: Icon(
                              Icons.info_outline,
                              size: 28.0,
                              color: ThemeColors.background,
                            ),
                            leftBarIndicatorColor: Colors.blue[300],
                          ).show(context);
                          await Navigator.pushNamed(
                              context, '/mainView');
                          // print(_heading.text + _description.text);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).schedule,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: ThemeColors.background,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => ScheduleNotificationsViewModel());
  }
}
