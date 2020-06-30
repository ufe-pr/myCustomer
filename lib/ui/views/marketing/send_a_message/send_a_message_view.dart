import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'send_a_message_viewmodel.dart';

class Stuff extends StatelessWidget {
  final bgColor = Colors.white;
  final color = Colors.blueAccent[700];
  final outlineColor = Colors.grey[200];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440,width: 720,allowFontScaling: true);
    return ViewModelBuilder<StuffModel>.reactive(
      viewModelBuilder: ()=> StuffModel(),
      builder: (context,model,child){
        return Scaffold(
          backgroundColor: bgColor,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    height: 120.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {}, // TODO: implement back button
                          icon: Icon(
                            Icons.keyboard_backspace,
                            color: color,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Send a Message',
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(
                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: outlineColor, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          )
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 30.sp,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0,),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: outlineColor,
                              width: 2.0
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: color,
                              width: 2.0
                          ),
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 30.sp
                      ),
                      minLines: 4,
                      maxLines: 100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w, right: 60.w,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          value: model.checkBoxValue,
                          onChanged: model.checkBoxFunction(true),
                          //tristate: true,
                          autofocus: true,
                          activeColor: color,
                        ),
                        Text(
                          'See Templates',
                          style: TextStyle(
                            color: color,
                            fontSize: 27.sp,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Swipe to see more',
                          style: TextStyle(
                            fontSize: 27.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40.w,),
                    height: 100.h,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: model.templateList.map((template) {
                        return GestureDetector(
                          onTap: () {
                            model.onTap(template);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              border: Border.all(
                                  color: model.currentIndex ==
                                      model.templateList.indexOf(template)
                                      ? color
                                      : outlineColor),
                            ),
                            padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.symmetric(horizontal: 20.sp),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              template,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: model.currentIndex ==
                                    model.templateList.indexOf(template)
                                    ? color
                                    : outlineColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 40.h, horizontal: 40.w),
                    padding: EdgeInsets.symmetric(
                        vertical: 30.h, horizontal: 30.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      border: Border.all(color: outlineColor),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${model
                                  .numberOfSelectedCustomers} Selected Customer(s)',
                              style: TextStyle(
                                  fontSize: 25.sp
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.add, color: color, size: 30.sp,),
                                Text(
                                  'Add',
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 25.sp,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          constraints: BoxConstraints.tight(
                              Size.fromHeight(60)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model.numberOfSelectedCustomers,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                                  child: CircleAvatar(
                                    radius: 40.sp,
                                    backgroundColor: color,
                                    // TODO: implement customer Profile Picture
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 60.w, right: 60.w),
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Center(
                      child: Text(
                        'Send',
                        style: TextStyle(
                            color: bgColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}