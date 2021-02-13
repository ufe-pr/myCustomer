import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_image.dart';
import 'package:mycustomers/ui/shared/const_text.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';
import 'add_customer_viewmodel.dart';
import 'package:mycustomers/core/extensions/string_extension.dart';

class AddCustomerView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCustomerViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: customizeAppBar(context, 1.0,
                  title: kaddCustomerHeadingText,
                  arrowColor: BrandColors.primary),
              //  AppBar(
              //   title: Text(kaddCustomerHeadingText),
              //   backgroundColor: Colors.transparent,
              //   elevation: 0,
              //   centerTitle: false,
              //   textTheme: Theme.of(context).textTheme.copyWith(headline6: TextStyle(
              //     fontSize: 18.sp,
              //     fontWeight: FontWeight.bold,
              //     color: ThemeColors.black,
              //   ),),
              //   iconTheme: IconThemeData(color: ThemeColors.black),
              // ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image(
                                image: kaddCustomerImage,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                child: Text(
                                  kaddCustomerBodyText1.capitalize,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  kaddCustomerBodyText2,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                    color: ThemeColors.gray.shade500),
                              ),
                              child: Text(
                                AppLocalizations.of(context).addFromContacts,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              color: BrandColors.secondary,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            child: FlatButton(
                              onPressed: () {
                                _navigationService.navigateTo(
                                    Routes.addCustomerManuallyDebtor);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: BrandColors.secondary),
                              ),
                              child: Text(
                                AppLocalizations.of(context).addManually,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              textColor: BrandColors.secondary,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              color: BrandColors.secondary.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => AddCustomerViewModel());
  }
}
