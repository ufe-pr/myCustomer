import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'partial_build_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class PartialBuildsView extends StatelessWidget {
  const PartialBuildsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PartialBuildsViewModel>.reactive(
      builder: (context, model, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            model.subTitle,
            style: TextStyle(fontSize: 18.sp, color: ThemeColors.black),
          ),
          SizedBox(height: 16.0),
          _StringForm(),
          Spacer(),
          Container(
            width: double.infinity,
            child: FlatButton(
              color: BrandColors.secondary,
              onPressed: () {
                print('here');
                //model.addContact();
                //Navigator.pushNamed(context, '/mainTransaction');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                AppLocalizations.of(context).nextButton,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      viewModelBuilder: () => PartialBuildsViewModel(),
    );
  }
}

class _StringForm extends HookViewModelWidget<PartialBuildsViewModel> {
  _StringForm({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
      BuildContext context, PartialBuildsViewModel model) {
    var name = useTextEditingController();
    var phoneNumber = useTextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff77869e),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person),
                ),
                Container(
                  height: 24.0,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xff77869e),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).enterName,
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      controller: name,
                      onChanged: model.updateName,
                    ),
                  ),
                ),
              ],
            )),
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
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: model.dropDownValue,
                    items: model.countryCode
                        .map<DropdownMenuItem<String>>((String value) {
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
                Container(
                    height: 24.0,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Color(0xff77869e))))),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).mobileNumber,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: phoneNumber,
                    onChanged: model.updateContact,
                  ),
                )
              ],
            )),
      ],
    );
  }
}
