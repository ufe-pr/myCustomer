import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'message_viewmodel.dart';

import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/core/models/customer.dart';

import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/send_message_viewmodel.dart';

import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';

class MessageView extends StatelessWidget {
  final MessageArgument arguments;
//  final List<Customer> selectedCustomers;
  MessageView(this.arguments);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    ScreenUtil.init(
      context,
      height: height,
      width: width,
    );
    return ViewModelBuilder<MessageViewModel>.reactive(
      viewModelBuilder: () => MessageViewModel(),
      builder: (context, model, child) {
        model.initSelected(arguments.selectedCustomers);
        model.setQuickText(arguments.title, arguments.message);
        final int length = model.selectedCustomers.length != 0
            ? model.selectedCustomers.length
            : arguments.selectedCustomers.length;
        print(arguments.selectedCustomers.length);

//        arguments.selectedCustomers.length;
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).sendAMessage,
              arrowColor: BrandColors.secondary),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(AppLocalizations.of(context).title),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter Title of message',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.gray)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BrandColors.secondary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
//                      maxLines: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(AppLocalizations.of(context).message),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    controller: model.messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.gray)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BrandColors.secondary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: ThemeColors.gray),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              length == 1
                                  ? '$length ' + AppLocalizations.of(context).selectedCustomer
                                  : '$length ' + AppLocalizations.of(context).selectedCustomer + 's',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            FlatButton.icon(
                              onPressed: () async {
                                final bool isPermitted =
                                    await model.checkPermission();
                                if (!isPermitted) {
                                  permissionDialog(context, model);
                                } else {
                                  showModalBottomSheet(
                                    enableDrag: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BottomSheetView(
                                          model.selectedCustomers,
                                          height,
                                          model);
                                    },
                                  );
                                }
//                                await model.initSelected(selectedCustomers);
                                // showModalBottomSheet(
                                //   enableDrag: true,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.only(
                                //       topLeft: Radius.circular(20),
                                //       topRight: Radius.circular(20),
                                //     ),
                                //   ),
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return BottomSheetView(model.selectedCustomers,height, model);
                                //   },
                                // );
                              },
                              icon: Icon(
                                Icons.add,
                                color: BrandColors.primary,
                              ),
                              label: Text(
                                AppLocalizations.of(context).add,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: BrandColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: length,
                            itemBuilder: (BuildContext context, int index) =>
                                CustomerCircleAvatar(
                              customer: model.selectedCustomers.length != 0
                                  ? model.selectedCustomers[index]
                                  : arguments.selectedCustomers[index],
                              action: 'debtor',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
                    child: FlatButton(
                      onPressed: () {
//                        model.navigateToSendMessage();
                        successDialog(context, model);
                      },
                      color: BrandColors.secondary,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        width: width,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).send,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      onModelReady: (model) {
        model.init();
      },
    );
  }

  Future<void> permissionDialog(
      BuildContext context, MessageViewModel model) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF333CC1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      AppLocalizations.of(context).accessDenied,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    child: Text(
                      AppLocalizations.of(context)
                          .myCustomerNeedsAccessToYourContacts,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Flushbar(
                                backgroundColor: BrandColors.primary,
                                duration: const Duration(seconds: 3),
                                message:
                                    'You denied permission to your contacts',
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: ThemeColors.background,
                                ),
                                leftBarIndicatorColor: Colors.blue[300],
                              ).show(context);
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).deny,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);

                              model.requestPermission();
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).allow,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> successDialog(
      BuildContext context, MessageViewModel model) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
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
                        model.returnHome();
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
        barrierDismissible: true,
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
}

class BottomSheetView extends StatelessWidget {
  final List<Customer> selectedCustomers;
  final double height;
  final MessageViewModel parentModel;
  BottomSheetView(this.selectedCustomers, this.height, this.parentModel);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageViewModel>.reactive(
      viewModelBuilder: () => MessageViewModel(),
      builder: (context, model, child) {
        return Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.xMargin(context, 5),
            right: SizeConfig.xMargin(context, 5),
            top: SizeConfig.yMargin(context, 2),
          ),
          child: Container(
            height: height,
            child: Column(
//              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).selectContacts),
                    FlatButton(
                      color: const Color(0xFFDEE9FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: () {
                        parentModel
                            .mergeSelectCustomer(model.selectedCustomers);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3.5),
                          color: BrandColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.gray.shade700,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: TextField(
                          controller: model.searchController,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context).typeCustomerName,
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.transparent,
                            focusColor: Colors.transparent,
                          ),
                          onChanged: model.search,
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                      Expanded(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context).backgroundColor
                                    : ThemeColors.gray.shade400,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'PHONE CONTACTS',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                            model.isLoadBusy /* || !model.dataReady*/
                                ? SliverToBoxAdapter(
                                    child: Center(
                                      child: LoadingAnimation(),
                                    ),
                                  )
                                :
//
                                SliverPadding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.w),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          Customer customer = model.data[index];
                                          bool _isSelected =
                                              model.isSelected(customer);
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.h,
                                                horizontal: 10.w),
                                            child: Row(
                                              children: <Widget>[
                                                CustomerCircleAvatar(
                                                  customer: customer,
                                                  action: 'debtor',
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30.w),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          '${customer.name} '
                                                          '${customer.lastName}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 3.sp,
                                                        ),
                                                        Text(
                                                          '${customer.phone}',
                                                          style: TextStyle(
                                                            color: ThemeColors
                                                                .gray.shade600,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Checkbox(
                                                    activeColor:
                                                        BrandColors.primary,
                                                    value: _isSelected,
                                                    onChanged: (value) {
                                                      _isSelected
                                                          ? model
                                                              .deselectCustomer(
                                                                  customer)
                                                          : model
                                                              .selectCustomer(
                                                                  customer);
                                                    })
                                              ],
                                            ),
                                          );
                                        },
                                        childCount: model.data.length,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onModelReady: (model) {
        model.init();
      },
    );
  }
}