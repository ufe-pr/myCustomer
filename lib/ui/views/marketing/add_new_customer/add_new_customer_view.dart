import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_new_customer_viewmodel.dart';

class AddNewCustomerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewCustomerViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: customizeAppBar(context, 1.0,
                title: model.title, arrowColor: BrandColors.secondary),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                       AppLocalizations.of(context).customerName,
                      style:
                          TextStyle(fontSize: 18.sp, color: ThemeColors.black),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.gray,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextField(
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Enter Name of customer',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              controller: model.name,
                            ),
                          ),
                        )),
                    SizedBox(height: 16.0),
                    Text(
                       AppLocalizations.of(context).customerPhoneNo,
                      style:
                          TextStyle(fontSize: 18.sp, color: ThemeColors.black),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff77869e),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.phone_android,
                                    color: ThemeColors.gray)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                underline: Container(),
                                value: model.dropDownValue,
                                items: model.countryCode
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  model.updateCountryCode(newValue);
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(),
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText:  AppLocalizations.of(context).mobileNumber,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                                controller: model.phoneNumber,
                                onChanged: model.updateContact,
                              ),
                            )
                          ],
                        )),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        color: BrandColors.primary,
                        onPressed: () {
                          !model.validateNumber()
                              ? Flushbar(
                                  backgroundColor: BrandColors.primary,
                                  duration: const Duration(seconds: 3),
                                  message: 'Enter a valid number',
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 28.0,
                                    color: ThemeColors.background,
                                  ),
                                  leftBarIndicatorColor: Colors.blue[300],
                                ).show(context)
                              : !model.validateName()
                                  ? Flushbar(
                                      backgroundColor: BrandColors.primary,
                                      duration: const Duration(seconds: 3),
                                      message: 'Enter a customer Name',
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: ThemeColors.background,
                                      ),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context)
                                  : model.sendMessage();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          AppLocalizations.of(context).continueButton,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        viewModelBuilder: () => AddNewCustomerViewModel());
  }
}
