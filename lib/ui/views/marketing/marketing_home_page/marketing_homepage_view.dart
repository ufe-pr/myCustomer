import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:flushbar/flushbar.dart';
import 'marketing_homepage_viewmodel.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Color backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).backgroundColor
        : ThemeColors.gray[400];
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: true);
    return ViewModelBuilder<MarketingHomePageViewModel>.reactive(
      builder: (context, model, child) =>
          // Scaffold(
          // // backgroundColor:BrandColors.primary,
          // body:
          Container(
        color: Theme.of(context).backgroundColor,
        child: Column(children: <Widget>[
          Container(
            width: width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).marketing,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cursorColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .showYourCustomersThatYouReallyCare,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).cursorColor),
                    ),
                  ]),
            ),
          ),
          model.allCustomers.length != 0
              ? Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[500],
                )
              : Container(),
          model.allCustomers.length == 0
              ? Expanded(
                  child: Container(
                    width: width,
                    // height: height,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRect(
                                child: Image(
                                  height: height / 4,
                                  image:
                                      AssetImage('assets/images/megaphone.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 3),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .itsAllAboutSendingMessagesToCustomers,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).textSelectionColor),
                                textAlign: TextAlign.center,
// =======
//                               Container(
//                                 color: ThemeColors.gray[400],
//                                 height: 50.h,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: InkWell(
//                                         child: Container(
//                                           decoration: BoxDecoration(
// //                                        color: ThemeColors.gray,
//                                               color: ThemeColors.gray[400],
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0)),
//                                           child: Center(
//                                             child: Text(
//                                               AppLocalizations.of(context)
//                                                   .addACustomer,
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: ThemeColors.gray[400]),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10.w,
//                                     ),
//                                     Expanded(
//                                       child: InkWell(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               color: BrandColors.secondary,
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0)),
//                                           child: Center(
//                                             child: Text(
//                                               AppLocalizations.of(context)
//                                                   .sendMessage,
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
// >>>>>>> language
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).customerList,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                child: Container(
                                  color:
                                      BrandColors.secondary.withOpacity(0.07),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Send message', // AppLocalizations.of(context)
                                          // .sendMessageAll,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: BrandColors.secondary),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5),
                          child: Container(
                            child: TextField(
                              controller: model.searchController,
                              onChanged: model.search,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: AppLocalizations.of(context)
                                    .typeCustomerName,
                                border: InputBorder.none,
                                focusColor: BrandColors.primary,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey[500],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        model.allFrequentCustomers.length == 0
                            ? Container()
                            : Container(
                                width: double.infinity,
                                height: 15.h,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .frequentlyContacted,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: BrandColors.primary),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 5.h,
                        ),
                        model.allFrequentCustomers.length == 0
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(0.0),
                                    itemCount: 1,
//                                  itemCount: model.allFrequentCustomers.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Customer customer =
                                          model.allFrequentCustomers[index];
                                      bool _isSelected =
                                          model.isSelected(customer);
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 15.h,
                                            ),
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
                                                            horizontal: 10.w),
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
                                                                .gray.shade800,
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
                                                          : model.addCustomer(
                                                              customer);
                                                    })
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey[500],
                                          )
                                        ],
                                      );
                                    }),
                              ),
                        model.allFrequentCustomers.length == 0
                            ? Container()
                            : SizedBox(
                                height: 10.h,
                              ),
                        model.allCustomers.length == 0
                            ? Container()
                            : Container(
                                width: double.infinity,
                                height: 15.h,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    AppLocalizations.of(context).all,
//                                'Frequently contacted',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: BrandColors.primary),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 5.h,
                        ),
                        model.allCustomers.length == 0
                            ? Center(
                                child: LoadingAnimation(),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(0.0),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        model.searchController.text != null
                                            ? model.searchedCustomer.length
                                            : model.allCustomers.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Customer customer =
                                          model.searchController.text != null
                                              ? model.searchedCustomer[index]
                                              : model.allCustomers[index];
                                      bool _isSelected =
                                          model.isSelected(customer);
                                      return Dismissible(
                                        background: Container(
                                          color: BrandColors.secondary,
                                        ),
                                        key: UniqueKey(),
                                        onDismissed:
                                            (DismissDirection direction) {
                                          model.removeCustomers(customer);
                                        },
                                        // onDismissed: (direction) =>
                                        //     model.removeCustomers(index),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 15.h,
                                              ),
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
                                                              horizontal: 10.w),
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
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3.sp,
                                                          ),
                                                          Text(
                                                            '${customer.phone}',
                                                            style: TextStyle(
                                                              color: ThemeColors
                                                                  .gray
                                                                  .shade800,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                            : model.addCustomer(
                                                                customer);
                                                      })
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey[500],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
//                         Expanded(
//                  child: Container(
//                    color: ThemeColors.gray[400],
//                    width: width,
//                    child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: SingleChildScrollView(
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 5.h,
//                                  ),
//                                  Container(
//                                    padding: const EdgeInsets.symmetric(
//                                      horizontal: 20.0,
//                                    ),
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Text(
//                                          'Customer List',
//                                          style: TextStyle(
//                                            fontSize: 20.sp,
//                                          ),
//                                        ),
//                                        Text(
//                                          'Send message to all',
//                                          style: TextStyle(
//                                              fontSize: 14.sp,
//                                              color: BrandColors.secondary),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 10.h,
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 15.0, vertical: 10),
//                                    child: Container(
//                                      child: TextField(
//                                        controller: model.searchController,
//                                        onChanged: model.search,
//                                        textInputAction: TextInputAction.search,
//                                        decoration: InputDecoration(
//                                          prefixIcon: Icon(Icons.search),
//                                          hintText: 'Type customer name',
//                                          border: InputBorder.none,
//                                          focusColor: BrandColors.primary,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0, vertical: 10),
//                                    child: Text('All'),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0),
//                                    child: ListView.builder(
//                                        shrinkWrap: true,
//                                        physics: NeverScrollableScrollPhysics(),
//                                        itemCount:
//                                            model.searchController.text != null
//                                                ? model.searchedCustomer.length
//                                                : model.allCustomers.length,
//                                        itemBuilder:
//                                            (BuildContext context, int index) {
//                                          Customer customer = model
//                                                      .searchController.text !=
//                                                  null
//                                              ? model.searchedCustomer[index]
//                                              : model.allCustomers[index];
//                                          bool _isSelected =
//                                              model.isSelected(customer);
//                                          return Dismissible(
//                                            background: Container(color: Colors.red,),
//                                            key: Key(index.toString()),
//                                            onDismissed: (direction)=>model.removeCustomers(index),
//                                            child: MyListTile(
//                                              leading: CustomerCircleAvatar(
//                                                  customer: customer),
//                                              title: Text(
//                                                customer.lastName!=null?
//                                                '${customer.name} '
//                                                '${customer.lastName}':'${customer.name} ',
//                                                style: TextStyle(
//                                                  fontWeight: FontWeight.w600,
//                                                ),
//                                              ),
//                                              subtitle: Text(
//                                                '${customer.phone}',
//                                                style: TextStyle(
//                                                  color:
//                                                      ThemeColors.gray.shade600,
//                                                  fontWeight: FontWeight.w600,
//                                                ),
//                                              ),
//                                              trailing: Checkbox(
//                                                  activeColor:
//                                                      BrandColors.primary,
//                                                  value: _isSelected,
//                                                  onChanged: (value) {
//                                                    _isSelected
//                                                        ? model.deselectCustomer(
//                                                            customer)
//                                                        : model.addCustomer(
//                                                            customer);
//                                                  }),
//                                            ),
//                                          );
//                                        }),
//                                  )
//                                ],
//                              ),
//                            ),
//                          ),
//                        ]),
//                  ),
//                ),
//          model.allCustomers.length != 0
//              ? Container(
//                  color: Colors.transparent,
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(
//                        horizontal: 10, vertical: 10),
//                    child: Container(
//                      height: 50.h,
//                      color: Colors.transparent,
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Expanded(
//                            child: FlatButton(
//                              onPressed: () async{
//                                   final bool isPermitted = await model.checkPermission();
//                                   if(isPermitted){
//                                     model.navigateToAddCustomers(context);
//
//                                   }else{
//                                     permissionDialog(context, model);
//                                   }
//                                   model.navigateToAddCustomer();
//                                },
//                              color: BrandColors.primary,
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(5.0)),
//                              child: Container(
//                                child: Center(
//                                  child: Text(
//                                    'New Contacts',
//                                    style: TextStyle(
//                                        fontSize: 14.sp, color: Colors.white),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                          SizedBox(width: 5.h,),
//                          Expanded(
//                            child: FlatButton(
//
//                              onPressed: () { model.selectedCustomers.length !=0?
//                               model.navigateToSendMessageView():
//                                Flushbar(
//                                      backgroundColor: BrandColors.primary,
//                                      duration: const Duration(seconds: 3),
//                                      message: 'Select a customer from the list or add new contacts',
//                                      icon: Icon(
//                                        Icons.info_outline,
//                                        size: 28.0,
//                                        color: ThemeColors.background,
//                                      ),
//                                      leftBarIndicatorColor: Colors.blue[300],
//                                    ).show(context);
//                               },
//                              color: BrandColors.secondary,
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(5.0)),
//                              child: Container(
//                                child: Center(
//                                  child: Text(
//                                    'Send message',
//                                    style: TextStyle(
//                                        fontSize: 14.sp, color: Colors.white),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                )
          model.allCustomers.length != 0
              ? Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              model.selectedCustomers.length != 0
                                  ? model.navigateToSendMessageView()
                                  : Flushbar(
                                      backgroundColor: BrandColors.primary,
                                      duration: const Duration(seconds: 3),
                                      message:
                                          'Select a customer from the list',
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: ThemeColors.background,
                                      ),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                              //  model.navigateToAddCustomer();
                            },
                            color: BrandColors.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Container(
                              width: width / 3,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).sendMessage,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.end,
//                          children: <Widget>[
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Text('Add New Customer',style: TextStyle(
//                            fontSize: 14.sp),),
//                                SizedBox(width: 10.w,),
//                                FloatingActionButton(
//                                  onPressed:(){},
//                                  backgroundColor: Colors.white,
//                                  child: Icon(Icons.add,color: BrandColors.primary,),
//                                ),
//                              ],
//                            ),
//                            SizedBox(height: 20.h,),
//                            Container(
//                          height: 50.h,
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            children: <Widget>[
//                              FlatButton(
//                                onPressed: ()async{
//                                   final bool isPermitted = await model.checkPermission();
//                                   if(isPermitted){
//                                     model.navigateToAddCustomers(context);
//
//                                   }else{
//                                     permissionDialog(context, model);
//                                   }
//                                  //  model.navigateToAddCustomer();
//                                },
//                                color: BrandColors.secondary,
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(5.0)),
//                                child: Container(
//                                  width: width / 3,
//                                  child: Center(
//                                    child: Text(
//                                      'Send message',
//                                      style: TextStyle(
//                                          fontSize: 14.sp, color: Colors.white),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        )
//                          ],
//                        ),
                  ),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              final bool isPermitted =
                                  await model.checkPermission();
                              if (isPermitted) {
                                model.navigateToAddCustomers(context);
                              } else {
                                permissionDialog(context, model);
                              }
                              //  model.navigateToAddCustomer();
                            },
                            color: BrandColors.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Container(
                              width: width / 3,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).sendMessage,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.end,
//                          children: <Widget>[
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Text('Add New Customer',style: TextStyle(
//                            fontSize: 14.sp),),
//                                SizedBox(width: 10.w,),
//                                FloatingActionButton(
//                                  onPressed:(){},
//                                  backgroundColor: Colors.white,
//                                  child: Icon(Icons.add,color: BrandColors.primary,),
//                                ),
//                              ],
//                            ),
//                            SizedBox(height: 20.h,),
//                            Container(
//                          height: 50.h,
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            children: <Widget>[
//                              FlatButton(
//                                onPressed: ()async{
//                                   final bool isPermitted = await model.checkPermission();
//                                   if(isPermitted){
//                                     model.navigateToAddCustomers(context);
//
//                                   }else{
//                                     permissionDialog(context, model);
//                                   }
//                                  //  model.navigateToAddCustomer();
//                                },
//                                color: BrandColors.secondary,
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(5.0)),
//                                child: Container(
//                                  width: width / 3,
//                                  child: Center(
//                                    child: Text(
//                                      'Send message',
//                                      style: TextStyle(
//                                          fontSize: 14.sp, color: Colors.white),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        )
//                          ],
//                        ),
                  ),
                ),

//              : Expanded(
//                  child: Container(
//                    color: ThemeColors.gray[400],
//                    width: width,
//                    child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: SingleChildScrollView(
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 5.h,
//                                  ),
//                                  Container(
//                                    padding: const EdgeInsets.symmetric(
//                                      horizontal: 20.0,
//                                    ),
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Text(
//                                          'Customer List',
//                                          style: TextStyle(
//                                            fontSize: 20.sp,
//                                          ),
//                                        ),
//                                        Text(
//                                          'Send message to all',
//                                          style: TextStyle(
//                                              fontSize: 14.sp,
//                                              color: BrandColors.secondary),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 10.h,
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 15.0, vertical: 10),
//                                    child: Container(
//                                      child: TextField(
//                                        controller: model.searchController,
//                                        onChanged: model.search,
//                                        textInputAction: TextInputAction.search,
//                                        decoration: InputDecoration(
//                                          prefixIcon: Icon(Icons.search),
//                                          hintText: 'Type customer name',
//                                          border: InputBorder.none,
//                                          focusColor: BrandColors.primary,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0, vertical: 10),
//                                    child: Text('All'),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0),
//                                    child: ListView.builder(
//                                        shrinkWrap: true,
//                                        physics: NeverScrollableScrollPhysics(),
//                                        itemCount:
//                                            model.searchController.text != null
//                                                ? model.searchedCustomer.length
//                                                : model.allCustomers.length,
//                                        itemBuilder:
//                                            (BuildContext context, int index) {
//                                          Customer customer = model
//                                                      .searchController.text !=
//                                                  null
//                                              ? model.searchedCustomer[index]
//                                              : model.allCustomers[index];
//                                          bool _isSelected =
//                                              model.isSelected(customer);
//                                          return MyListTile(
//                                            leading: CustomerCircleAvatar(
//                                                customer: customer),
//                                            title: Text(
//                                              '${customer.name} '
//                                              '${customer.lastName}',
//                                              style: TextStyle(
//                                                fontWeight: FontWeight.w600,
//                                              ),
//                                            ),
//                                            subtitle: Text(
//                                              '${customer.phone}',
//                                              style: TextStyle(
//                                                color:
//                                                    ThemeColors.gray.shade600,
//                                                fontWeight: FontWeight.w600,
//                                              ),
//                                            ),
//                                            trailing: Checkbox(
//                                                activeColor:
//                                                    BrandColors.primary,
//                                                value: _isSelected,
//                                                onChanged: (value) {
//                                                  _isSelected
//                                                      ? model.deselectCustomer(
//                                                          customer)
//                                                      : model.addCustomer(
//                                                          customer);
//                                                }),
//                                          );
//                                        }),
//                                  )
//                                ],
//                              ),
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.symmetric(
//                                horizontal: 20.0, vertical: 10),
//                            child: Container(
//                              color: Theme.of(context).backgroundColor,
//                              height: 50.h,
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Expanded(
//                                    child: InkWell(
//                                      onTap: () =>
//                                          model.navigateToAddCustomer(),
//                                      // =>Navigator.pushNamed(context, '/addCustomerMarketing'),
//                                      child: Container(
//                                        decoration: BoxDecoration(
//                                            color: BrandColors.primary,
//                                            borderRadius:
//                                                BorderRadius.circular(5.0)),
//                                        child: Center(
//                                          child: Text(
//                                            'Add a customer',
//                                            style: TextStyle(
//                                                fontSize: 14.sp,
//                                                color: Colors.white),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    width: 10.w,
//                                  ),
//                                  Expanded(
//                                    child: InkWell(
//                                      onTap: () {
//                                        // Navigator.pushNamed(context, '/sendMessage');
////                                        model.selectedCustomers
////                                            .length ==
////                                            0
////                                            ??
//                                        model.sendMessage();
//                                      },
//                                      child: Container(
//                                        decoration: BoxDecoration(
//                                            color: model.selectedCustomers
//                                                        .length ==
//                                                    0
//                                                ? ThemeColors.gray
//                                                : BrandColors.secondary,
//                                            borderRadius:
//                                                BorderRadius.circular(5.0)),
//                                        child: Center(
//                                          child: Text(
//                                            'Send message',
//                                            style: TextStyle(
//                                                fontSize: 14.sp,
//                                                color: Colors.white),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ]),
//                  ),
//                ),
        ]),
      ),
      // ),
      viewModelBuilder: () => MarketingHomePageViewModel(),
    );
  }

  Future<void> permissionDialog(
      BuildContext context, MarketingHomePageViewModel model) async {
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
                              model.navigateToAddNewCustomer(context);
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
}
