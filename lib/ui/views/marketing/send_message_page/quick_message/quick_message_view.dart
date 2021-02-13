import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/quick_message/quick_message_viewmodel.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/send_message_viewmodel.dart';

class QuickMessageView extends StatelessWidget {
//  final MessageArgument arguments;
  final List<Customer> selectedCustomers;
  QuickMessageView(this.selectedCustomers);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(
      context,
      height: height,
      width: width,
    );
    return ViewModelBuilder<QuickMessageViewModel>.reactive(
      viewModelBuilder: () => QuickMessageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
//              title: 'Quick messages',
              title: AppLocalizations.of(context).sendMessage,
              arrowColor: BrandColors.secondary),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  itemCount: quickMessageTitle.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.h,
                      ),
                      FlatButton(
                        onPressed: () => model.navigateToMessageView(
                            selectedCustomers,
                            quickMessageTitle[index],
                            quickMessageText[index]),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: BrandColors.secondary.withOpacity(0.5))),
                        child: Container(
                          height: 100.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        quickMessageTitle[index],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        quickMessageText[index],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: BrandColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                FlatButton(
                  color: BrandColors.secondary,
                  onPressed: () {
                    model.navigateToMessage(
                      selectedCustomers,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 50.h,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).composeMessage,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
//          body: SingleChildScrollView(
//            child: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20),
//              child: Container(
//                child: Column(
//                  children: <Widget>[
//                    ListView.builder(itemBuilder: (BuildContext context, int index)=>FlatButton(
//                      onPressed: () =>
//                          model.navigateToMessageView(selectedCustomers),
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5),
//                          side: BorderSide(color: BrandColors.secondary)),
//                      child: Container(
//                        height: 100.h,
//                        child: Padding(
//                          padding: const EdgeInsets.all(10.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Expanded(
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      'Happy new year',
//                                      style: TextStyle(
//                                        color: BrandColors.secondary,
//                                        fontSize: 16.sp,
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      height: 5.h,
//                                    ),
//                                    Text(
//                                      'Best Wishes from me',
//                                      style: TextStyle(
//                                        fontSize: 16.sp,
//                                        color: BrandColors.secondary,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Icon(
//                                Icons.navigate_next,
//                                color: BrandColors.secondary,
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),),
//                    SizedBox(
//                      height: 20.h,
//                    ),
//                    FlatButton(
//                      onPressed: () =>
//                          model.navigateToMessageView(selectedCustomers),
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5),
//                          side: BorderSide(color: BrandColors.secondary)),
//                      child: Container(
//                        height: 100.h,
//                        child: Padding(
//                          padding: const EdgeInsets.all(10.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Expanded(
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      'Happy new year',
//                                      style: TextStyle(
//                                        color: BrandColors.secondary,
//                                        fontSize: 16.sp,
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      height: 5.h,
//                                    ),
//                                    Text(
//                                      'Best Wishes from me',
//                                      style: TextStyle(
//                                        fontSize: 16.sp,
//                                        color: BrandColors.secondary,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Icon(
//                                Icons.navigate_next,
//                                color: BrandColors.secondary,
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                    SizedBox(
//                      height: 20.h,
//                    ),
//                    FlatButton(
//                      onPressed: () =>
//                          model.navigateToMessageView(selectedCustomers),
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5),
//                          side: BorderSide(color: BrandColors.secondary)),
//                      child: Container(
////                        width: width,
//                        height: 100.h,
//                        child: Padding(
//                          padding: const EdgeInsets.all(10.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Expanded(
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      'Season\'s Greetings!',
//                                      style: TextStyle(
//                                        color: BrandColors.secondary,
//                                        fontSize: 16.sp,
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      height: 5.h,
//                                    ),
//                                    Text(
//                                      'Wishing you a happy new year!',
//                                      style: TextStyle(
//                                        fontSize: 16.sp,
//                                        color: BrandColors.secondary,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Icon(
//                                Icons.navigate_next,
//                                color: BrandColors.secondary,
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
        );
      },
    );
  }
}
