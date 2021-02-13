import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/models/customer.dart';

import 'import_customer_viewmodel.dart';

class ImportCustomerView extends StatelessWidget {
  final String action;

  const ImportCustomerView({Key key, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImportCustomerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              automaticallyImplyLeading: false,
              pinned: true,
              titleSpacing: 15.w,
              title: _SearchBar(model: model),
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              actions: <Widget>[
                FlatButton(
                  onPressed: model.popView,
                  child: Text(
                    AppLocalizations.of(context).cancel,
                    style: TextStyle(
                        color: action == AppLocalizations.of(context).debtor
                            ? Theme.of(context).textSelectionColor
                            : BrandColors.secondary,
                        fontSize: SizeConfig.yMargin(context, 2.5)),
                  ),
                  padding: EdgeInsets.all(2),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.blurBackground,
                ],
                titlePadding: EdgeInsets.zero,
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    //margin: EdgeInsets.only(top: 15),
                    //padding: EdgeInsets.symmetric(vertical: 10),
                    child: MyListTile(
                      centerTitle: true,
                      onTap: () => model.goToManual(action),
                      leading: CustomerCircleAvatar(
                        bgColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.person_add,
                          color: action == AppLocalizations.of(context).debtor
                              ? Theme.of(context).textSelectionColor
                              : BrandColors.secondary,
                          size: SizeConfig.xMargin(context, 7),
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).addNewCustomer,
                        style: TextStyle(
                            color: action == AppLocalizations.of(context).debtor
                                ? Theme.of(context).textSelectionColor
                                : BrandColors.secondary,
                            fontSize: SizeConfig.yMargin(context, 2.3)),
                      ),
                      trailing: IconButton(
                        onPressed: () => model.goToManual(action),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                          color: action == AppLocalizations.of(context).debtor
                              ? BrandColors.primary
                              : BrandColors.secondary,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                      ),
                    ),
                  ),
                ),
//                  preferredSize: Size.fromHeight(110),
              ),
              //bottom: PreferredSize(child: Container(), preferredSize: Size.fromHeight(10)),
              expandedHeight: 140,
            ),
            SliverPersistentHeader(
              delegate: TitleHeader(40, action),
              pinned: true,
            ),
            model.isLoadBusy /* || !model.dataReady*/
                ? SliverToBoxAdapter(
                    child: Center(
                      child: LoadingAnimation(),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 8.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Customer customer = model.data[index];
                          return MyListTile(
                            action: action,
                            leading: Center(
                                child: CustomerCircleAvatar(
                              customer: customer,
                              action: action,
                            )),
                            title: Text(
                              '${customer.displayName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.yMargin(context, 1.9)),
                            ),
                            subtitle: Text(
                              '${customer.phone.isNotEmpty ? customer.phone : 'No number'}',
                              style: TextStyle(
                                  color: ThemeColors.gray.shade600,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.yMargin(context, 2)),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 3),
                              child: FlatButton.icon(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: SizeConfig.yMargin(context, 1.6),
                                ),
                                onPressed: () {
                                  model.addContact(
                                      customer.displayName,
                                      customer.phone.isNotEmpty
                                          ? customer.phone
                                          : AppLocalizations.of(context)
                                              .noNumber,
                                      customer.initials,
                                      action);
                                },
                                label: Text(
                                  AppLocalizations.of(context).add,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: SizeConfig.yMargin(context, 1.5),
                                  ),
                                ),
                                textColor: Colors.white,
                                color: action ==
                                        AppLocalizations.of(context).debtor
                                    ? BrandColors.primary
                                    : BrandColors.secondary,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
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
      viewModelBuilder: () => ImportCustomerViewModel(),
      onModelReady: (model) {
        model.init();
      },
    );
  }
}

class TitleHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final String action;

  TitleHeader(this.height, this.action);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: this.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ThemeColors.gray.shade400,
        boxShadow: !overlapsContent
            ? null
            : [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 8,
                  color: ThemeColors.gray.shade600,
                )
              ],
      ),
      child: Text(
        // This is just the text formatting for singular and plural
        action == AppLocalizations.of(context).debtor
            ? AppLocalizations.of(context).addDebtorsFromContacts
            : AppLocalizations.of(context).addCreditorFromContacts,
        style: TextStyle(
            color: ThemeColors.black,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textSize(context, 4.5)),
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

class _SearchBar extends StatefulWidget {
  final ImportCustomerViewModel model;

  const _SearchBar({Key key, this.model}) : super(key: key);

  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: Remove Container and use appropriate properties
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.gray.shade700,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5.w),
//        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: TextField(
        controller: widget.model.searchController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).search,
          hintStyle: TextStyle(fontSize: SizeConfig.yMargin(context, 2.5)),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).cursorColor,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          fillColor: Colors.transparent,
          focusColor: Colors.transparent,
          contentPadding:
              EdgeInsets.only(bottom: SizeConfig.yMargin(context, 1.3)),
        ),
        style: TextStyle(fontSize: 18),
        onChanged: widget.model.search,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
