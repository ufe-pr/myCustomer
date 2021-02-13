import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'add_debt_viewmodel.dart';

class AddDebtView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<AddDebtViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              brightness: Brightness.light,
              elevation: 1,
              title: Text(
                model.amount != null
                    ? 'Sheyi ${AppLocalizations.of(context).owesYou} \$' + model.amount.toString()
                    : 'Sheyi ${AppLocalizations.of(context).owesYou}',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8C5F),
                    ),
              ),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18),
                      vertical: ScreenUtil().setHeight(10)),
                  child: SvgPicture.asset(
                    'assets/icons/backarrow.svg',
                    color: const Color(0xFFFF8C5F),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(20),
                  horizontal: ScreenUtil().setWidth(20)),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(20)),
                              child: Text(
                                AppLocalizations.of(context).customerDetails,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(15)),
                              child: TextField(
                                maxLines: null,
                                maxLengthEnforced: false,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Color(0xFFFF8C5F),
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.bold),
                                decoration: new InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFFF8C5F), width: 2.0),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFFF8C5F), width: 2.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFFF8C5F), width: 2.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFFF8C5F), width: 2.0),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  hintText:
                                      AppLocalizations.of(context).enterAmount,
                               //   errorText: model.error,
                                  prefixIcon: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(15),
                                        horizontal: ScreenUtil().setWidth(10)),
                                    child: SvgPicture.asset(
                                      'assets/icons/hash.svg',
                                      color: const Color(0xFFFF8C5F),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(8)),
                                ),
                                textInputAction: TextInputAction.go,
                                onChanged: model.updateAmount,
                              ),
                            ),
                            Visibility(
                              visible: model.show,
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      final DateTime picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: model.selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2300),
                                      );
                                      if (picked != null) model.setDate(picked);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(15),
                                          horizontal:
                                              ScreenUtil().setWidth(15)),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFFD1D1D1),
                                              width: 2.0),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(5))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    ScreenUtil().setWidth(15)),
                                            child: SvgPicture.asset(
                                              'assets/icons/calendar.svg',
                                              color: const Color(0xFFFF8C5F),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              model.newDate ??
                                                  AppLocalizations.of(context)
                                                      .selectDueDate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    color: Color(0xFFFF8C5F),
                                                  ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(10),
                                        vertical: ScreenUtil().setHeight(4)),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFD1D1D1),
                                            width: 2.0),
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setWidth(5))),
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: _controller,
                                          maxLines: null,
                                          maxLengthEnforced: false,
                                          keyboardType: TextInputType.multiline,
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .enterItemspurchased,
                                            hintStyle: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(15)),
                                            prefixIcon: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: ScreenUtil()
                                                      .setHeight(10)),
                                              child: SvgPicture.asset(
                                                'assets/icons/cart.svg',
                                                color: const Color(0xFFFF8C5F),
                                              ),
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                _controller.clear();
                                                model.addItem();
                                              },
                                              child: Container(
                                                width:
                                                    ScreenUtil().setWidth(10),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.add,
                                                      color: Color(0xFFFF8C5F),
                                                      size: ScreenUtil()
                                                          .setWidth(18),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .addButton,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
                                                              color: Color(
                                                                  0xFFFF8C5F),
                                                            ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          textInputAction: TextInputAction.go,
                                          onSubmitted: (value) {
                                            _controller.clear();
                                            model.addItem();
                                          },
                                          onChanged: model.updateItem,
                                        ),
                                        for (var item in model.items)
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical:
                                                    ScreenUtil().setHeight(4)),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    ScreenUtil().setHeight(10),
                                                horizontal:
                                                    ScreenUtil().setWidth(15)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil().setWidth(5)),
                                              color: Color(0xFFF0F0F0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Flexible(
                                                    child: Text(
                                                      item,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4
                                                          .copyWith(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          16),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    model.removeItem(model.items
                                                        .indexOf(item));
                                                  },
                                                  child: Container(
                                                    child: SvgPicture.asset(
                                                        'assets/icons/cancel.svg'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  saveButton(model, width, context)
                ],
              ),
            )),
        viewModelBuilder: () => AddDebtViewModel());
  }
}

InkWell saveButton(AddDebtViewModel model, double width, BuildContext context) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color:
            model.save ? Color(0xFFFF8C5F) : Color(0xFFFF8C5F).withOpacity(0.5),
      ),
      width: width,
      child: Center(
        child: Text(
          AppLocalizations.of(context).save,
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: ScreenUtil().setSp(16),
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
