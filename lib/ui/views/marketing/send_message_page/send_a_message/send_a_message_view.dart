import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'send_a_message_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

import 'package:mycustomers/core/models/customer.dart';

class SendAMessage extends StatelessWidget {
  final List<Customer> selectedCustomers;
  SendAMessage(this.selectedCustomers);

  final bgColor = Colors.white;
  final color = Colors.blueAccent[700];
  final outlineColor = Colors.grey[200];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(
      context,
      height: height,
      width: width,
    );
    return ViewModelBuilder<StuffModel>.reactive(
      viewModelBuilder: () => StuffModel(),
      builder: (context, model, child) {
//        print(selectedCustomers.length);
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).sendAMessage,
              arrowColor: BrandColors.secondary),
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.h,
                    ),
                    FlatButton(
                      color: BrandColors.secondary.withOpacity(0.3),
                      onPressed: () {
//                        Flushbar(
//                          backgroundColor: BrandColors.primary,
//                          duration: const Duration(seconds: 3),
//                          message: 'Quick message feature coming soon',
//                          icon: Icon(
//                            Icons.info_outline,
//                            size: 28.0,
//                            color: ThemeColors.background,
//                          ),
//                          leftBarIndicatorColor: Colors.blue[300],
//                        ).show(context);
                        model.navigateToQuickMessage(selectedCustomers);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        height: 120.h,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TypewriterAnimatedTextKit(
                                speed: Duration(milliseconds: 300),
                                repeatForever: true,
                                // pause: Duration(seconds: 10),
                                displayFullTextOnTap: true,
                                stopPauseOnTap: true,
                                text: [
                                  AppLocalizations.of(context).quickMessage
                                ],
                                textStyle: TextStyle(
                                  color: BrandColors.secondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24.sp,
                                ),
                              ),
                              // Text(
                              //   'Quick message',style: TextStyle(
                              //   color: BrandColors.secondary,
                              //   fontWeight: FontWeight.w500,
                              //   fontSize: 24.sp,
                              //   ),
                              // ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .weHaveAlreadyMadeMessagesForYou,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: BrandColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FlatButton(
                      color: BrandColors.secondary,
                      onPressed: () {
                        model.navigateToMessage(selectedCustomers);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        height: 120.h,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).composeMessage,
                                style: TextStyle(
                                  color: bgColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24.sp,
                                ),
                              ),
                              //  TyperAnimatedTextKit(
                              //     speed: Duration(milliseconds: 300),
                              //     isRepeatingAnimation: true,
                              //     // repeatForever: true,
                              //     displayFullTextOnTap: true,
                              //     stopPauseOnTap: true,
                              //     text: [
                              //       'Compose message',
                              //     ],
                              //     textStyle: TextStyle(
                              //       color: bgColor,
                              //       fontWeight: FontWeight.w500,
                              //       fontSize: 24.sp,
                              //     ),
                              //   ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .createUniqueMessagesForCustomers,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: bgColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
