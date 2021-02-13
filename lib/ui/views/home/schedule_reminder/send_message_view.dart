import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'schedule_remider_viewmodel.dart';
class SendReminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<ScheduleReminderViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=>Navigator.of(context).pop(),
            icon:Icon(Icons.arrow_back,color: BrandColors.primary),
          ),
          title: Text(AppLocalizations.of(context).sendReminder,style:  TextStyle(
            fontSize: 18.sp,),),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: <Widget>[
                TextField(
                  style:  TextStyle(
                    fontSize: 16.sp,),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).typeAHeading,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color:  ThemeColors.gray[500],),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color:  BrandColors.primary,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                TextField(
                style:  TextStyle(
                  fontSize: 16.sp,),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).startTypingYourmessage,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color:  ThemeColors.gray[500],),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color:  BrandColors.primary,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
          ),
          child: BottomAppBar(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                child: Container(
                  height: 50.h,

                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                            onTap: ()=> Navigator.pushNamed(context, '/scheduleReminder'),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: BrandColors.buttonBorder),
                              color: ThemeColors.gray[500],
                            ),
                            child: Center(
                              child: Text(AppLocalizations.of(context).schedule,style:  TextStyle(fontSize: 18.sp,
                              color: BrandColors.primary),
                          ),
                            ),
                        )),
                      ),
                      SizedBox(width: 10.w,),
                      Expanded(
                        child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: BrandColors.primary,
                              ),


                              child: Center(
                                child: Text(AppLocalizations.of(context).sendCapital,style:  TextStyle(fontSize: 18.sp,
                                color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ScheduleReminderViewModel(),
    );
  }
}
