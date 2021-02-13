import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart' as appbar;
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:mycustomers/ui/widgets/shared/custom_raised_button.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import 'add_customer_message_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/models/customer.dart';

class AddCustomerMessageView extends StatelessWidget {
  final String action;
  final List<Customer> frequent;

  const AddCustomerMessageView({Key key, this.action, this.frequent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).brightness==Brightness.dark?Theme.of(context).backgroundColor :ThemeColors.gray.shade600;

    return ViewModelBuilder<AddCustomerMessageViewModel>.reactive(

      builder: (context, model, child) {
        model.getFrequentCustomers(frequent);
        return Scaffold(
          appBar: customizeAppBar(context, 0.0, title: 'Send a Message', arrowColor: Theme.of(context).backgroundColor),
//        appBar: customizeAppBar(context, 0.0, title: 'Select contacts', arrowColor: BrandColors.secondary),
          body: Column(
          children: <Widget>[
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(

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
                    hintText: 'Type customer name',
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                    context, '/addNewCustomerMarketing'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 15.h, horizontal: 10.w),
//

                  child: Row(
                    children: <Widget>[
                      CustomerCircleAvatar(
                        child: Icon(
                          Icons.person_add,
                          color: ThemeColors.cta,
                        ),
                        bgColor: ThemeColors.gray.shade500,
                      ),
                      Expanded(
                        child: Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 30.w
//                                  : 10.w
                          ),
                          child: Text(
                            'Add customer Manually',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: BrandColors.secondary,
                              fontSize: 16.sp,
//                                        color: model.allSelected
//                                            ? ThemeColors.gray.shade800
//                                            : ThemeColors.cta,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  model.allFrequentCustomers.length == 0
                      ? SliverToBoxAdapter(child: Container(),)
                      : SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 40,
                      color: backgroundColor,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'FREQUENT CUSTOMERS',
                        style:
                        TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  model.allFrequentCustomers.length == 0
                      ? SliverToBoxAdapter(
                    child: Container(),)
                      :SliverToBoxAdapter(child: SizedBox(height: 10.h),)
                  ,
                  model.allFrequentCustomers.length == 0?
                  SliverToBoxAdapter(child: Container(),) :
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 10),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          Customer customer = model.allFrequentCustomers[index];
                          bool _isSelected =
                          model.isSelected(customer);
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 10.w),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CustomerCircleAvatar(
                                      customer: customer,
                                      action: 'debtor',
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
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
                                              : model.selectCustomer(
                                              customer);
                                        })
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: 4,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      height: 40,
                      color: backgroundColor,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).phoneContacts,
                        style:
                            TextStyle(fontWeight: FontWeight.w600),
                      ),
                                ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                  model.isLoadBusy || !model.dataReady
                      ? SliverToBoxAdapter(
                    child: Center(
                      child: LoadingAnimation(),
                    ),
                  )
                      :
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 10),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          Customer customer = model.data[index];
                          bool _isSelected =
                          model.isSelected(customer);
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CustomerCircleAvatar(
                                      customer: customer,
                                      action: 'debtor',
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
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
                                              : model.selectCustomer(
                                              customer);
                                        })
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                ),
                              ],
                            ),
                          );
//                              MyListTile(
//                              action: action,
//                              leading: Center(child: CustomerCircleAvatar(customer: customer, action: action,)),
//                              title: Text(
//                                '${customer.displayName}',
//                                style: TextStyle(
//                                    fontWeight: FontWeight.w600,
//                                    fontSize: SizeConfig.yMargin(context, 1.9)
//                                ),
//                              ),
//                              subtitle: Text(
//                                '${customer.phone.isNotEmpty ? customer.phone : 'No number'}',
//                                style: TextStyle(
//                                    color: ThemeColors.gray.shade600,
//                                    fontWeight: FontWeight.w600,
//                                    fontSize: SizeConfig.yMargin(context, 2)
//                                ),
//                              ),
//                              trailing: Container(
//                                //padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
//                                child: FlatButton.icon(
//                                  icon: Icon(
//                                    Icons.add,
//                                    color: Colors.white,
//                                    size: SizeConfig.yMargin(context, 1.6),
//                                  ),
//                                  onPressed: () {
//                                    model.addContact(customer.displayName, customer.phone.isNotEmpty ? customer.phone : 'No number', customer.initials, action);
//                                  },
//                                  label: Text(
//                                    'ADD',
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.w600,
//                                      fontSize: SizeConfig.yMargin(context, 1.5),
//                                    ),
//                                  ),
//                                  textColor: Colors.white,
//                                  color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
//                                  padding: EdgeInsets.zero,
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(4),
//                                  ),
//                                ),
//                              ),
//                            );
                        },
                        childCount: model.data.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30.w),
//              padding: EdgeInsets.all(30.w),
              child: FlatButton(
                onPressed: () {
                  model.selectedCustomers.length !=0?
                  model.sendMessage():
                  Flushbar(
                    backgroundColor: BrandColors.primary,
                    duration: const Duration(seconds: 3),
                    message: 'Select a customer from the list',
                    icon: Icon(
                      Icons.info_outline,
                      size: 28.0,
                      color: ThemeColors.background,
                    ),
                    leftBarIndicatorColor: Colors.blue[300],
                  ).show(context);
                },
                color: BrandColors.secondary,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).continueButton,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );},
      viewModelBuilder: () => AddCustomerMessageViewModel(),
      onModelReady: (model) {
        model.init();
      },
    );
//    return ViewModelBuilder<AddCustomerMessageViewModel>.reactive(
//      builder: (context, model, child) => Scaffold(
//        appBar: customizeAppBar(context, 1.0,
//            title: 'Select contacts', arrowColor: BrandColors.secondary),
//        body: Container(
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 10),
//            child: Column(
//              children: <Widget>[
//                Expanded(
//                  child: Column(
//                    children: <Widget>[
//                      SizedBox(
//                        height: 5.h,
//                      ),
//                      Container(
//                        decoration: BoxDecoration(
//                          border: Border.all(
//                            color: ThemeColors.gray.shade700,
//                            width: 1.5,
//                          ),
//                          borderRadius: BorderRadius.circular(5.w),
//                        ),
//                        clipBehavior: Clip.hardEdge,
//                        child: TextField(
//                          controller: model.searchController,
//                          decoration: InputDecoration(
//                            hintText: 'Type customer name',
//                            prefixIcon: Icon(Icons.search),
//                            border: InputBorder.none,
//                            focusedBorder: InputBorder.none,
//                            enabledBorder: InputBorder.none,
//                            fillColor: Colors.transparent,
//                            focusColor: Colors.transparent,
//                          ),
//                          onChanged: model.search,
//                          textInputAction: TextInputAction.search,
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 5),
//                        child: InkWell(
//                          onTap: () => Navigator.pushNamed(
//                              context, '/addNewCustomerMarketing'),
//                          child: Container(
//                            padding: EdgeInsets.symmetric(
//                                vertical: 15.h, horizontal: 10.w),
////
//
//                            child: Row(
//                              children: <Widget>[
//                                CustomerCircleAvatar(
//                                  child: Icon(
//                                    Icons.person_add,
//                                    color: ThemeColors.cta,
//                                  ),
//                                  bgColor: ThemeColors.gray.shade500,
//                                ),
//                                Expanded(
//                                  child: Container(
//                                    margin:
//                                        EdgeInsets.symmetric(horizontal: 30.w
////                                  : 10.w
//                                            ),
//                                    child: Text(
//                                      'Add New Customer',
//                                      style: TextStyle(
//                                        //todo:dreplace this
////                                        color: model.allSelected
////                                            ? ThemeColors.gray.shade800
////                                            : ThemeColors.cta,
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                      Expanded(
//                        child: SingleChildScrollView(
//                          physics: AlwaysScrollableScrollPhysics(),
//                          child: Column(
//                            mainAxisSize: MainAxisSize.min,
//                            children: <Widget>[
//                              model.allFrequentCustomers.length == 0
//                                  ? Container()
//                                  :Container(
//                                width: double.infinity,
//                                height: 40,
//                                color: backgroundColor,
//                                alignment: Alignment.centerLeft,
//                                child: Padding(
//                                  padding: const EdgeInsets.symmetric(
//                                      horizontal: 10),
//                                  child: Text(
//                                    'FREQUENT CUSTOMERS',
//                                    style:
//                                        TextStyle(fontWeight: FontWeight.w600),
//                                  ),
//                                ),
//                              ),
//                              model.allFrequentCustomers.length == 0
//                                  ? Container()
//                                  :SizedBox(height: 10.h),
//                              model.allFrequentCustomers.length == 0
//                                  ? Container()
////                                  :ListView.builder(
////                                      itemCount: 4,
////                                      shrinkWrap: true,
////                                      physics: NeverScrollableScrollPhysics(),
////                                      itemBuilder:
////                                          (BuildContext context, int index) {
////                                        Customer customer =
////                                            model.allCustomers[index];
//                                        bool _isSelected =
//                                            model.isSelected(customer);
//                                        return Container(
//                                          padding: EdgeInsets.symmetric(
//                                              vertical: 15.h, horizontal: 10.w),
//                                          child: Row(
//                                            children: <Widget>[
//                                              CustomerCircleAvatar(
//                                                customer: customer,
//                                                action: 'debtor',
//                                              ),
//                                              Expanded(
//                                                child: Container(
//                                                  margin: EdgeInsets.symmetric(
//                                                      horizontal: 30.w),
//                                                  child: Column(
//                                                    mainAxisSize:
//                                                        MainAxisSize.min,
//                                                    crossAxisAlignment:
//                                                        CrossAxisAlignment
//                                                            .start,
//                                                    children: <Widget>[
//                                                      Text(
//                                                        '${customer.name} '
//                                                        '${customer.lastName}',
//                                                        style: TextStyle(
//                                                          fontWeight:
//                                                              FontWeight.w600,
//                                                        ),
//                                                      ),
//                                                      SizedBox(
//                                                        height: 3.sp,
//                                                      ),
//                                                      Text(
//                                                        '${customer.phone}',
//                                                        style: TextStyle(
//                                                          color: ThemeColors
//                                                              .gray.shade600,
//                                                          fontWeight:
//                                                              FontWeight.w600,
//                                                        ),
//                                                      )
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                              Checkbox(
//                                                  activeColor:
//                                                      BrandColors.primary,
//                                                  value: _isSelected,
//                                                  onChanged: (value) {
//                                                    _isSelected
//                                                        ? model
//                                                            .deselectCustomer(
//                                                                customer)
//                                                        : model.addCustomer(
//                                                            customer);
//                                                  })
//                                            ],
//                                          ),
//                                        );
////                                      }),
//                              Container(
//                                width: double.infinity,
//                                height: 40,
//                                color: backgroundColor,
//                                alignment: Alignment.centerLeft,
//                                child: Padding(
//                                  padding: const EdgeInsets.symmetric(
//                                      horizontal: 10),
//                                  child: Text(
//                                    'PHONE CONTACTS',
//                                    style:
//                                        TextStyle(fontWeight: FontWeight.w600),
//                                  ),
//                                ),
//                              ),
//                              SizedBox(height: 10.h),
//                              model.isBusy  || !model.dataReady
//                                  ? Center(
//                                      child: LoadingAnimation(),
//                                    )
//                                  : ListView.builder(
//                                      shrinkWrap: true,
//                                      physics: NeverScrollableScrollPhysics(),
//                                      itemCount: model.data.length,
//                                      itemBuilder:
//                                          (BuildContext context, int index) {
//                                        Customer customer =model.data[index];
//                                        bool _isSelected =
//                                            model.isSelected(customer);
////                                    return MyListTile(
////                                      leading:
////                                      CustomerCircleAvatar(customer: customer),
////                                      title: Text(
////                                        '${customer.name} '
////                                            '${customer.lastName}',
////                                        style: TextStyle(
////                                          fontWeight: FontWeight.w600,
////                                        ),
////                                      ),
////                                      subtitle: Text(
////                                        '${customer.phone}',
////                                        style: TextStyle(
////                                          color: ThemeColors.gray.shade600,
////                                          fontWeight: FontWeight.w600,
////                                        ),
////                                      ),
////                                      trailing:  Checkbox(
////                                          activeColor:
////                                          BrandColors.primary,
////                                          value: _isSelected,
////                                          onChanged: (value) {
////                                            _isSelected
////                                                ? model.deselectCustomer(
////                                                customer)
////                                                : model.addCustomer(
////                                                customer);
////                                          }),
////                                    );
//                                        return Container(
//                                          padding: EdgeInsets.symmetric(
//                                              vertical: 15.h, horizontal: 10.w),
//                                          child: Row(
//                                            children: <Widget>[
//                                              CustomerCircleAvatar(
//                                                customer: customer,
//                                                action: 'debtor',
//                                              ),
//                                              Expanded(
//                                                child: Container(
//                                                  margin: EdgeInsets.symmetric(
//                                                      horizontal: 30.w),
//                                                  child: Column(
//                                                    mainAxisSize:
//                                                        MainAxisSize.min,
//                                                    crossAxisAlignment:
//                                                        CrossAxisAlignment
//                                                            .start,
//                                                    children: <Widget>[
//                                                      Text(
//                                                        '${customer.name} '
//                                                        '${customer.lastName}',
//                                                        style: TextStyle(
//                                                          fontWeight:
//                                                              FontWeight.w600,
//                                                        ),
//                                                      ),
//                                                      SizedBox(
//                                                        height: 3.sp,
//                                                      ),
//                                                      Text(
//                                                        '${customer.phone}',
//                                                        style: TextStyle(
//                                                          color: ThemeColors
//                                                              .gray.shade600,
//                                                          fontWeight:
//                                                              FontWeight.w600,
//                                                        ),
//                                                      )
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                              Checkbox(
//                                                  activeColor:
//                                                      BrandColors.primary,
//                                                  value: _isSelected,
//                                                  onChanged: (value) {
//                                                    _isSelected
//                                                        ? model
//                                                            .deselectCustomer(
//                                                                customer)
//                                                        : model.selectCustomer(
//                                                            customer);
//                                                  })
//                                            ],
//                                          ),
//                                        );
//                                      }),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  padding: EdgeInsets.all(30.w),
//                  child: FlatButton(
//                    onPressed: () {
//                      model.returnCustomers();
//                    },
//                    color: BrandColors.secondary,
//                    padding: EdgeInsets.symmetric(vertical: 15.0),
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(5.0),
//                    ),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Text(
//                          'Continue',
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//      viewModelBuilder: () => AddCustomerMessageViewModel(),
//      onModelReady: (model) {
//        model.init();
//      },
//    );
  }
}

class NewContactsHeader extends SliverPersistentHeaderDelegate {
  final double height;

  NewContactsHeader(this.height);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding:EdgeInsets.symmetric(vertical: 10.w,horizontal: 10),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
            context, '/addNewCustomerMarketing'),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 15.h, horizontal: 10.w),
//

          child: Row(
            children: <Widget>[
              CustomerCircleAvatar(
                child: Icon(
                  Icons.person_add,
                  color: ThemeColors.cta,
                ),
                bgColor: ThemeColors.gray.shade500,
              ),
              Expanded(
                child: Container(
                  margin:
                  EdgeInsets.symmetric(horizontal: 30.w
//                                  : 10.w
                  ),
                  child: Text(
                    'Add New Customer',
                    style: TextStyle(
                      //todo:dreplace this
//                                        color: model.allSelected
//                                            ? ThemeColors.gray.shade800
//                                            : ThemeColors.cta,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => this.height;

  @override
  double get minExtent => this.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

