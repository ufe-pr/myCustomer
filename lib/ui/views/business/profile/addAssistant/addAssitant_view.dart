import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:stacked/stacked.dart';
import 'addAssistant_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';

class AddAssistantView extends StatelessWidget {
  static TextEditingController _assistantNameController;
  static TextEditingController _inputNumberController;
  static TextEditingController _assistantRoleController;

  final _formKey1 = GlobalKey<FormState>();
  static final _pageKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);

    return ViewModelBuilder<AddAssistantViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key: _pageKey,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: ThemeColors.background,
          centerTitle: true,
          title: Text(model.title, style: kheadingText),
          iconTheme: IconThemeData(color: BrandColors.secondary),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              model.navigateBack();
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(28.sp),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.subTitle,
                    textAlign: TextAlign.justify, style: model.textStyle),
                SizedBox(height: 34.h),
                Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          //TODO Implement Routing to the add customer from contact list
                        },
                        child: CircleAvatar(
                            backgroundColor: Color(0xffD4D6F0),
                            child: Icon(
                              Icons.person_add,
                              color: BrandColors.secondary,
                            ))),
                    SizedBox(width: 14.w),
                    Text(
                      model.frmContact,
                      style: TextStyle(
                          color: ThemeColors.black,
                          fontSize: 20.sp,
                          letterSpacing: -0.02),
                    )
                  ],
                ),
                SizedBox(height: 32.h),
                Text(
                  model.addManually,
                  style: model.textStyle,
                ),
                Expanded(
                  child: Container(
                    height: 240.h,
                    margin: EdgeInsets.only(top: 8.h),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.05),
                        border: Border.all(
                            color: Color.fromRGBO(196, 196, 196, 0.05),
                            width: 0.5),
                        borderRadius: BorderRadius.circular(11.sp)),
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              model.nameLabel,
                              textAlign: TextAlign.left,
                              style: model.formTextStyle,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) =>
                                    model.validateFields(value),
                                controller: _assistantNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: model.nameHintText,
                                    hintStyle: model.hinttextStyle,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.all(14.sp)),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              model.roleLabel,
                              textAlign: TextAlign.left,
                              style: model.formTextStyle,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) =>
                                    model.validateFields(value),
                                controller: _assistantRoleController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: model.roleHintText,
                                    hintStyle: model.hinttextStyle,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.all(14.sp)),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              model.phoneNumberLabel,
                              textAlign: TextAlign.left,
                              style: model.formTextStyle,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) =>
                                    model.validateFields(value),
                                controller: _inputNumberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: model.phoneNumberHintText,
                                    hintStyle: model.hinttextStyle,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.all(14.sp)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: 105.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 18.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: BrandColors.secondary),
                  child: FlatButton(
                      onPressed: () {
                        //TODO Implement the action to be completed once the user clicks the save button
                      },
                      child: Text(model.btnText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.background,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.sp,
                          ))),
                ),
              ]),
        )),
      ),
      viewModelBuilder: () => AddAssistantViewModel(),
    );
  }
}
