import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'send_reminder_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'send_reminder_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class SendMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    // ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SendMessageViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).sendReminder,
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
                            height: 30.h,
                          ),
                          Container(
                            child: TextField(
                              style: TextStyle(height: SizeConfig.yMargin(context, 0.002)),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context).typeAHeading,
                                hintStyle:
                                    TextStyle(color: BrandColors.greyedText),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                            height: SizeConfig.yMargin(context, 6),
                            child: messageSnippetHolder(context, model)),
                            SizedBox(
                              height: 15.h,),
                          Container(
                            child: TextField(
                              style: TextStyle(height: SizeConfig.yMargin(context, 0.18)),
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .startTypingYourmessage,
                                hintStyle:
                                    TextStyle(color: BrandColors.greyedText),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.gray, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: ThemeColors.background,
                          elevation: 0,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/scheduleNotifications');
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                               side: BorderSide(
                                color:BrandColors.primary )
                              ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).schedule,
                              style: TextStyle(
                                  fontSize: 18.sp, color: BrandColors.primary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: BrandColors.primary,
                          elevation: 0,
                          onPressed: () {
                                Flushbar(
                                      backgroundColor: BrandColors.primary,
                                      duration: const Duration(seconds: 3),
                                      message: 'Could not send message in development ',
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: ThemeColors.background,
                                      ),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                             
                              ),
                              
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).send,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: ThemeColors.background,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
      viewModelBuilder: () => SendMessageViewModel(),
    );
  }
}

Widget messageSnippet(String value, SendMessageViewModel model, BuildContext context){
  return Container(
  margin:EdgeInsets.only(left:SizeConfig.yMargin(context, 1.2)) ,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color:ThemeColors.unselect
  ),
  child:FlatButton(
    onPressed: ()=> print('Button has been pressed'), 
    child: Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: BrandColors.primary,
        fontSize: SizeConfig.textSize(context, 4.4)
      ),
    )
    )
);
}

Widget messageSnippetHolder(BuildContext context, SendMessageViewModel model){
   return ListView.builder(
    itemCount: model.messageEntries.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (context, int index){
      return messageSnippet(model.messageEntries[index], model, context);
    }
    );

}