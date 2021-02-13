import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'message_sent_dialog_viewmodel.dart';

class MessageDialogView extends StatelessWidget {
  bool success = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageDialogViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        if (success) {
                          successDialog(context);
                        } else {
                          failureDialog(context);
                        }
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF333CC1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                               AppLocalizations.of(context).send,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MessageDialogViewModel(),
    );
  }
}

Future<void> successDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true, // TODO: change to false
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF333CC1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.check_circle,
                    color: Color(0xFF27AE60),
                    size: 70,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  child: Text(
                     AppLocalizations.of(context).messageSent,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      //TODO: route to screen
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                             AppLocalizations.of(context).continueButton,
                            style: TextStyle(
                              color: Color(0xFF333CC1),
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> failureDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true, // TODO: change to false
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF333CC1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 70,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  child: Text(
                    'Failed to send!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      //TODO: route to screen
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Retry',
                            style: TextStyle(
                              color: Color(0xFF333CC1),
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
